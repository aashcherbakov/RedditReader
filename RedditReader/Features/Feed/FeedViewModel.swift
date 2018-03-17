//
//  FeedViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class FeedViewModel {

    enum State {
        case error
        case complete
    }

    private let resource: Resource
    private var posts: [Post]?

    var onStateChange: ((State) -> Void)?
    weak var presenter: Presenter?
    var displays: [FeedTableCellDisplay] = []

    init(resource: Resource) {
        self.resource = resource
    }

    func loadFeed() {
        presenter?.showActivityIndicator()
        resource.getFeed(url: "http://reddit.com/r/redditdev.json?limit=50") { [weak self]
            posts, error in

            self?.presenter?.hideActivityIndicator()
            if let posts = posts {
                self?.posts = posts
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
