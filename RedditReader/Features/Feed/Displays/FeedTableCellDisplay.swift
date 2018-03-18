//
//  FeedTableCellDisplay.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public struct FeedTableCellDisplay {

    let title: String?
    let author: String
    let entryDate: String
    let thumbnailUrl: String?
    let comments: String
    let postType: PostType

    init(title: String?, author: String, entryDate: Int, thumbnail: String?, comments: Int, type: PostType) {
        self.title = title
        self.author = author
        self.entryDate = "\(FeedTableCellDisplay.entryDateDescription(from: entryDate)) hours ago"
        self.thumbnailUrl = thumbnail
        self.comments = "Total comments: \(comments)"
        self.postType = type
    }

    private static func entryDateDescription(from entryDate: Int) -> Int {
        let dateCreated = Date(timeIntervalSince1970: TimeInterval(exactly: entryDate)!)
        let timeSinceNow = dateCreated.timeIntervalSinceNow
        return abs(NSInteger(timeSinceNow) / 3600)
    }

}
