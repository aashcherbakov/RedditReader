//
//  Resource.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public typealias Result = (PostBatch?, String) -> ()

/// Unifying protocol for Remote and Local resources
public protocol Resource {

    /// Fetches feed for provided url
    ///
    /// - Parameters:
    ///   - url: String with url
    ///   - completion: completion block that is called with PostBatch? and String with error message
    func getFeed(url: String, completion: @escaping Result)
    
}
