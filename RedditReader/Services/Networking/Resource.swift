//
//  Resource.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public typealias Result = (PostBatch?, String) -> ()

public protocol Resource {

    func getFeed(url: String, completion: @escaping Result)
    
}
