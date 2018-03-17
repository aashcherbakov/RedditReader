//
//  UIImageView+Extensions.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/16/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImageFrom(url: String?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil { return }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }
}
