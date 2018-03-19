//
//  ImageViewViewModel.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

/// Parameters for WebViewController
public struct WebViewParameters: Transferable {
    let imageUrl: String
}

/// ViewModel for WebViewController
public class WebViewViewModel {

    private weak var presenter: Presenter?
    private let imageUrl: String

    init(presenter: Presenter?, parameters: Transferable?) {
        self.presenter = presenter
        self.imageUrl = (parameters as! WebViewParameters).imageUrl
    }

    // MARK: - Internal functions

    /// Creates an URLRequest to load in WKWebView
    ///
    /// - Returns: URLRequest?
    func requestUrl() -> URLRequest? {
        var request: URLRequest
        do {
            request = try tryCreateUrlRequest()
            return request
        } catch InvalidUrlError.invalidString(let string) {
            presenter?.displayAlert(for: .error(message: string))
        } catch {
            presenter?.displayAlert(for: .error(message: "Unexpected error"))
        }
        return nil
    }

    /// Function to indicate that request started loading
    func didStartRequest() {
        presenter?.showActivityIndicator()
    }

    /// Function to indicate that request is completed
    func didCompleteRequest() {
        presenter?.hideActivityIndicator()
    }

    // MARK: - Private functions

    private func tryCreateUrlRequest() throws -> URLRequest {
        guard let url = URL(string: imageUrl) else {
            throw InvalidUrlError.invalidString(url: imageUrl)
        }

        let request = URLRequest(url: url)
        return request
    }

}
