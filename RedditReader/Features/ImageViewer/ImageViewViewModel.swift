//
//  ImageViewViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/18/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class ImageViewViewModel {

    private weak var presenter: Presenter?

    let imageUrl: String

    init(presenter: Presenter?, parameters: Transferable?) {
        self.presenter = presenter
        self.imageUrl = (parameters as! WebViewParameters).imageUrl
    }
    
}
