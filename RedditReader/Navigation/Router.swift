//
//  Router.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

/// Class responsible for navigation within the app
public class Router {

    private weak var controllerFactory: ControllerFactory!

    init(factory: ControllerFactory) {
        self.controllerFactory = factory
    }

    /// Moves app flow from current screen to provided destination
    ///
    /// - Parameters:
    ///   - destination: Destination enum value
    ///   - presenter: ViewController that is currently on screen
    ///   - navigationType: NavigationType enum value
    ///   - parameters: Transferable object that holds parameters for Destination screen
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
