//
//  AppEnvironment.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class AppEnvironment {

    private weak var window: UIWindow?
    private let controllerFactory: ControllerFactory

    init() {
        controllerFactory = ControllerFactory()
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
