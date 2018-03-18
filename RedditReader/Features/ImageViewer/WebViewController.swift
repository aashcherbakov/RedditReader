//
//  ImageViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit
import WebKit

public class WebViewController: BaseViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var viewModel: WebViewViewModel!

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.didStartRequest()
        do {
            let request = try viewModel.requestUrl()
            webView.navigationDelegate = self
            webView.load(request)
        } catch InvalidUrlError.invalidString(let string) {
            print("Invalid url \(string)")
        } catch {
            print("Unexpected error")
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.didCompleteRequest()
    }
}
