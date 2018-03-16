//
//  FeedViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class FeedViewModel {

    private let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }

    func loadFeed() {
        resource.getFeed(url: "http://reddit.com/r/redditdev.json?limit=50") { posts, error in
            print(posts)
        }
    }

}
