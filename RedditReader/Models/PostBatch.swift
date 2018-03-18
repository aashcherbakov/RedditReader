//
//  PostBatch.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public struct PostBatch {

    let after: String?
    let before: String?
    let distance: Int?
    let posts: [Post]

    init(posts: [Post], after: String?, before: String?, distance: Int?) {
        self.posts = posts
        self.after = after
        self.before = before
        self.distance = distance
    }
}