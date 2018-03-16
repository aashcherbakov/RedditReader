//
//  RootViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation
import UIKit

/// Root view controller of the app.
internal final class RootViewController: UIViewController {

    // MARK: - Override properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentViewController?.preferredStatusBarStyle ?? .default
    }

    // MARK: - Private properties

    private(set) var currentViewController: UIViewController?
    @IBOutlet weak var containerView: UIView!

    // MARK: - Internal functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// Displays given view controller as the new root view controller of the app.
    /// Removes current view controller from view if it exists.
    ///
    /// - Parameter viewController: View controller to display.
    func display(_ viewController: UIViewController, completion transitionComplete: (() -> Void)?) {
        let oldViewController = currentViewController
        let newViewController = viewController

        // Set currentViewController so that we can animate the status bar appearance.
        currentViewController = newViewController

        // Force load the view about to be presented.
        _ = newViewController.view

        addChildViewController(newViewController)
        oldViewController?.willMove(toParentViewController: nil)

        if let oldViewController = oldViewController {
            if oldViewController.presentedViewController != nil {
                oldViewController.dismiss(animated: true, completion: nil)
            }

            transition(
                from: oldViewController,
                to: newViewController,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    self.setNeedsStatusBarAppearanceUpdate()
            },
                completion: { (_) in
                    oldViewController.view.removeFromSuperview()
                    oldViewController.removeFromParentViewController()
                    transitionComplete?()
            }
            )
        } else {
            view.setNeedsLayout()
            view.layoutIfNeeded()
            containerView.addSubview(newViewController.view)
        }
    }

}
