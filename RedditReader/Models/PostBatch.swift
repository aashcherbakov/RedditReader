//
//  PostBatch.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

/// Representation of a batch of posts from reddit
public struct PostBatch {

    /// id of the "previous" batch
    let after: String?

    /// id of the last batch
    let before: String?

    /// List of posts
    let posts: [Post]

    init(posts: [Post], after: String?, before: String?) {
        self.posts = posts
        self.after = after
        self.before = before
    }
    
}
