//
//  ControllerFactory.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class ControllerFactory {

    private let resource: Resource
    var router: Router!

    init(resource: Resource) {
        self.resource = resource
    }

    func controllerFor(destination: Destination) -> Presenter {
        switch destination {
        case .feed: return createFeedController()
        case .imageView: return createImageViewController()
        }
    }

    func rootController() -> RootViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! RootViewController
        return controller
    }

    func initialController() -> UIViewController {
        return createFeedController() as! UIViewController
    }

    private func createFeedController() -> Presenter {
        let controller = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        let viewModel = FeedViewModel(resource: resource, router: router)
        viewModel.presenter = controller
        controller.viewModel = viewModel
        let navigationController = BaseNavigationController(rootViewController: controller)
        return navigationController
    }

    private func createImageViewController() -> Presenter {
        let controller = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        return controller
    }

}
