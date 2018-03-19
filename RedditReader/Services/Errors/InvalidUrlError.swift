//
//  URLError.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

/// Types of Url parsing errors
public enum InvalidUrlError: Error {
    case invalidString(url: String)
}
