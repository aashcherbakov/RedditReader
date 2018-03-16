//
//  RemoteResource.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class RemoteResource: Resource {

    typealias JSONDictionary = [String: Any]

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionTask?

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
                DispatchQueue.main.async { completion(self.posts, self.errorMessage) }
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

        guard let base = response!["data"] as? [String: Any], let postsArray = base["children"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }

        parsePosts(from: postsArray)
    }

    private func parsePosts(from array: [Any]) {
        var index = 0
        for dictionary in array {
            if let JSONDictionary = dictionary as? JSONDictionary,
                let data = JSONDictionary["data"] as? JSONDictionary,
                let thumbnail = data["thumbnail"] as? String,
                let title = data["title"] as? String,
                let numberOfComments = data["num_comments"] as? Int,
                let created = data["created"] as? Int,
                let author = data["author"] as? String {
                posts.append(Post(title: title, author: author, entryDate: created, thumbnailUrl: thumbnail, numberOfComments: numberOfComments))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }

}
