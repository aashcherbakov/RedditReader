//
//  ImageViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit
import WebKit

/// ViewController responsible for opening links in WKWebView
public class WebViewController: BaseViewController {

    @IBOutlet private weak var webView: WKWebView!
    var viewModel: WebViewViewModel!

    // MARK: - Overridden functions

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    // MARK: - Private functions
    
    private func setupData() {
        viewModel.didStartRequest()
        guard let request = viewModel.requestUrl() else {
            return
        }

        webView.navigationDelegate = self
        webView.load(request)
    }

}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.didCompleteRequest()
    }

}
