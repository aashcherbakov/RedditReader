//
//  ImageViewViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public struct WebViewParameters: Transferable {
    let imageUrl: String
}

public class WebViewViewModel {

    private weak var presenter: Presenter?
    private let imageUrl: String

    init(presenter: Presenter?, parameters: Transferable?) {
        self.presenter = presenter
        self.imageUrl = (parameters as! WebViewParameters).imageUrl
    }

    func requestUrl() throws -> URLRequest {
        guard let url = URL(string: imageUrl) else {
            throw InvalidUrlError.invalidString(url: imageUrl)
        }

        let request = URLRequest(url: url)
        return request
    }

    func didStartRequest() {
        presenter?.showActivityIndicator()
    }

    func didCompleteRequest() {
        presenter?.hideActivityIndicator()
    }

}
