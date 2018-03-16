//
//  RemoteResource.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class RemoreResource {

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionTask?

    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Post]?, String) -> ()

    var posts: [Post] = []
    var errorMessage = ""

    func getFeed(url: String, completion: @escaping QueryResult) {
        dataTask?.cancel()

        guard let url = URLComponents(string: url)?.url else { return }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                self.errorMessage += "Error: " + error.localizedDescription
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completion(self.posts, self.errorMessage)
                }
            }
        }

        dataTask?.resume()
    }

    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        posts.removeAll()

        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }

        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String {
                posts.append(Post(title: name))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
