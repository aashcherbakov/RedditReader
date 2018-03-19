//
//  Post.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation


/// Type of reddit post based on post_hint parameter
///
/// - image: contains image
/// - link: contains link
/// - undefined: neither (can be extended in future)
public enum PostType {
    case image(url: String)
    case link(url: String)
    case undefined
}

/// Representation of single reddit post
public struct Post {

    private enum LinkType: String {
        case image = "image"
        case link = "link"
    }

    let title: String?
    let author: String
    let entryDate: Int
    let thumbnailUrl: String?
    let numberOfComments: Int
    let type: PostType

    init(jsonDisctionary: JSONDictionary) {
        self.numberOfComments = jsonDisctionary["num_comments"] as? Int ?? 0
        self.entryDate = jsonDisctionary["created_utc"] as? Int ?? 0
        self.author = jsonDisctionary["author"] as? String ?? ""
        self.title = jsonDisctionary["title"] as? String

        let hint = jsonDisctionary["post_hint"] as? String
        let contentUrl = jsonDisctionary["url"] as? String

        self.type = Post.getTypeFrom(hint: hint, url: contentUrl) ?? .undefined
        self.thumbnailUrl = Post.getTumbnailUrl(from: jsonDisctionary["thumbnail"] as? String)
    }

    private static func getTypeFrom(hint: String?, url: String?) -> PostType? {
        guard let hint = hint, let url = url, let linkType = LinkType(rawValue: hint) else {
            return nil
        }

        switch linkType {
        case .image: return PostType.image(url: url)
        case .link: return PostType.link(url: url)
        }
    }

    private static func getTumbnailUrl(from url: String?) -> String? {
        guard let url = url, url.hasPrefix("http") else {
            return nil
        }

        return url
    }
}
