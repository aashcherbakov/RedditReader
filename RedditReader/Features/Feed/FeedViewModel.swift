//
//  FeedViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class FeedViewModel {

    struct Constants {
        static let feedUrl = "https://www.reddit.com/top.json"
        static let batchSize = 25
    }

    enum State {
        case error
        case complete(pages: String)
    }

    private let resource: Resource
    private let router: Router
    private var batch: PostBatch?
    private var distance: Int = Constants.batchSize
    private let urlFactory = FeedUrlFactory()

    var onStateChange: ((State) -> Void)?
    var displays: [FeedTableCellDisplay] = []
    weak var presenter: Presenter?

    init(resource: Resource, router: Router) {
        self.resource = resource
        self.router = router
    }

    func loadFeed() {
        presenter?.showActivityIndicator()
        resource.getFeed(url: Constants.feedUrl, completion: loadBatchCompleted)
    }

    func loadNext() {
        guard let after = batch?.after else { return }
        presenter?.showActivityIndicator()
        distance += Constants.batchSize
        resource.getFeed(url: urlFactory.buildUrl(for: .next(after: after)), completion: loadBatchCompleted)
    }

    func loadPrevious() {
        presenter?.showActivityIndicator()
        distance -= Constants.batchSize
        resource.getFeed(url: urlFactory.buildUrl(for: .previous(before: batch?.before, distance: distance)), completion: loadBatchCompleted)
    }

    func shouldDisplayPreviousButton() -> Bool {
        return distance <= 25
    }

    func didSelectDisplay(at index: Int) {
        guard index < displays.count else { return }

        let display = displays[index]
        switch display.postType {
        case .image(let url):
            router.navigate(to: .imageView, presenter: presenter, navigationType: .push, parameters: WebViewParameters(imageUrl: url))
        case .link(let url):
            router.navigate(to: .webView, presenter: presenter, navigationType: .push, parameters: WebViewParameters(imageUrl: url))
        case .undefined: break
        }
    }

    private func loadBatchCompleted(newBatch: PostBatch?, error: String) {
        presenter?.hideActivityIndicator()
        if let loadedBatch = newBatch {
            batch = loadedBatch
            createDisplays(from: loadedBatch.posts)
            onStateChange?(.complete(pages: createPagesDisplay()))
        } else {
            onStateChange?(.error)
        }
    }

    private func createPagesDisplay() -> String {
        if distance == Constants.batchSize {
            return "First 25 entries"
        } else {
            return "Entries \(distance - Constants.batchSize) to \(distance)"
        }
    }

    private func createDisplays(from posts: [Post]) {
        displays = posts.map {
            FeedTableCellDisplay(
                title: $0.title,
                author: $0.author,
                entryDate: $0.entryDate,
                thumbnail: $0.thumbnailUrl,
                comments: $0.numberOfComments,
                type: $0.type
            )
        }
    }

}
