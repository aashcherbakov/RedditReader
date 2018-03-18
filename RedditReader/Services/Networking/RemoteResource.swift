//
//  RemoteResource.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: Any]

public class RemoteResource: Resource {

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionTask?

    var batch: PostBatch?
    var posts: [Post] = []
    var errorMessage = ""

    public func getFeed(url: String, completion: @escaping Result) {
        dataTask?.cancel()

        guard let url = URLComponents(string: url)?.url else { return }

        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                self.errorMessage += "Error: " + error.localizedDescription
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self.updateSearchResults(data)
                DispatchQueue.main.async { completion(self.batch, self.errorMessage) }
            }
        }

        dataTask?.resume()
    }

    private func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        posts.removeAll()

        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }

        guard
            let base = response!["data"] as? [String: Any],
            let postsArray = base["children"] as? [Any]
        else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }

        let before = base["before"] as? String
        let after = base["after"] as? String
        let distance = base["dist"] as? Int

        parsePosts(from: postsArray)
        batch = PostBatch(posts: posts, after: after, before: before, distance: distance)
    }

    private func parsePosts(from array: [Any]) {
        for dictionary in array {
            if let JSONDictionary = dictionary as? JSONDictionary,
                let data = JSONDictionary["data"] as? JSONDictionary {
                posts.append(Post(jsonDisctionary: data))
            } else {
                errorMessage += "Problem parsing dictionary\n"
            }
        }
    }

}
