//
//  BaseNavigationController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/17/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class BaseNavigationController: UINavigationController, Presenter {
    
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
