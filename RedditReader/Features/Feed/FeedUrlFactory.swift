//
//  FeedUrlFactory.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/18/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public enum FeedUrlType {
    case initial
    case next(after: String)
    case previous(before: String?, distance: Int)
}

public class FeedUrlFactory {

    func buildUrl(for type: FeedUrlType) -> String {
        switch type {
        case .initial: return FeedViewModel.Constants.feedUrl
        case .next(let after):
            return nextUrl(after: after)
        case .previous(let before, let distance):
            return previousUrl(before: before, distance: distance)
        }
    }

    private func nextUrl(after: String) -> String {
        return FeedViewModel.Constants.feedUrl + "?count=\(FeedViewModel.Constants.batchSize)&after=\(after)"
    }

    private func previousUrl(before: String?, distance: Int) -> String {
        var url: String

        if let before = before, distance > FeedViewModel.Constants.batchSize {
            url = FeedViewModel.Constants.feedUrl + "?count=\(FeedViewModel.Constants.batchSize)&before=\(before)"
        } else {
            url = FeedViewModel.Constants.feedUrl
        }

        return url
    }

}
