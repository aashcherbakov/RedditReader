//
//  ControllerFactory.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

/// Class responsible for creating ViewControllers and injecting dependencies into ViewModels
public class ControllerFactory {

    private let resource: Resource

    /// Router instance
    var router: Router!

    init(resource: Resource) {
        self.resource = resource
    }

    /// Returns Presenter instance for given destination with injected parameters
    ///
    /// - Parameters:
    ///   - destination: Destination enum value
    ///   - parameters: Transferable? - nil by default
    /// - Returns: Presenter instance
    func controllerFor(destination: Destination, parameters: Transferable? = nil) -> Presenter {
        switch destination {
        case .feed: return createFeedController()
        case .webView: return createWebViewController(with: parameters)
        }
    }

    /// Returns RootViewController that will be used as a container for initial controller of app flow
    ///
    /// - Returns: RootViewController instance
    func rootController() -> RootViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! RootViewController
        return controller
    }

    /// Returns initial ViewController for user flow
    func initialController() -> UIViewController {
        return createFeedController() as! UIViewController
    }

    // MARK: - Private functions

    private func createFeedController() -> Presenter {
        let controller = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        let viewModel = FeedViewModel(resource: resource, router: router)
        viewModel.presenter = controller
        controller.viewModel = viewModel
        let navigationController = BaseNavigationController(rootViewController: controller)
        return navigationController
    }

    private func createWebViewController(with parameters: Transferable?) -> Presenter {
        let controller = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let viewModel = WebViewViewModel(presenter: controller, parameters: parameters)
        controller.viewModel = viewModel
        return controller
    }

}
