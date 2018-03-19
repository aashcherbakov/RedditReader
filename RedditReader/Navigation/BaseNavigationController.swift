//
//  BaseNavigationController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

/// Base class for any UINavigationController in the app.
public class BaseNavigationController: UINavigationController, Presenter {

    private let alertBuilder = AlertControllerBuilder()

    public func displayAlert(for type: AlertType) {
        let alertController = alertBuilder.build(from: type)
        topViewController?.present(alertController, animated: true, completion: nil)
    }

    public func showActivityIndicator() {
        let topController = topViewController as? Presenter
        topController?.showActivityIndicator()
    }

    public func hideActivityIndicator() {
        let topController = topViewController as? Presenter
        topController?.hideActivityIndicator()
    }

    public func present(controller: Presenter, navigationType: NavigationType) {
        guard let destinationController = controller as? UIViewController else { return }
        switch navigationType {
        case .modal:
            topViewController?.present(destinationController, animated: true, completion: nil)
        case .push:
            pushViewController(destinationController, animated: true)
        }
    }

}
