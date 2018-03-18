//
//  AppEnvironment.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

/// Central class used for dependency injection and initial routing setup
public class AppEnvironment {

    private weak var window: UIWindow?
    private let controllerFactory: ControllerFactory
    private let remoteResource: Resource = RemoteResource()
    private let router: Router

    init() {
        controllerFactory = ControllerFactory(resource: remoteResource)
        router = Router(factory: controllerFactory)
        controllerFactory.router = router
    }

    public func run(in window: UIWindow?) {
        let rootController = controllerFactory.rootController()
        let initialController = controllerFactory.initialController()
        rootController.display(initialController, completion: nil)

        self.window = window
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
    }

}
