//
//  FeedViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class FeedViewModel {

    private struct Constants {
        static let feedUrl = "https://www.reddit.com/top.json"
    }

    enum State {
        case error
        case complete
    }

    private let resource: Resource

    var onStateChange: ((State) -> Void)?
    var displays: [FeedTableCellDisplay] = []
    weak var presenter: Presenter?

    init(resource: Resource) {
        self.resource = resource
    }

    func loadFeed() {
        presenter?.showActivityIndicator()
        resource.getFeed(url: Constants.feedUrl) {
            [weak self] posts, error in

            self?.presenter?.hideActivityIndicator()
            if let posts = posts {
                self?.createDisplays(from: posts)
                self?.onStateChange?(.complete)
            } else {
                self?.onStateChange?(.error)
            }
        }
    }

    private func createDisplays(from posts: [Post]) {
        displays = posts.map {
            FeedTableCellDisplay(
                title: $0.title,
                author: $0.author,
                entryDate: $0.entryDate,
                thumbnail: $0.thumbnailUrl,
                comments: $0.numberOfComments
            )
        }
    }

}
