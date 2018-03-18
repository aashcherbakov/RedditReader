//
//  Router.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

public class Router {

    private weak var controllerFactory: ControllerFactory!

    init(factory: ControllerFactory) {
        self.controllerFactory = factory
    }

    func navigate(
        to destination: Destination,
        presenter: Presenter?,
        navigationType: NavigationType,
        parameters: Transferable? = nil) {

        guard let presenter = presenter else { return }
        let controller = controllerFactory.controllerFor(destination: destination, parameters: parameters)
        presenter.present(controller: controller, navigationType: navigationType)
    }

}
