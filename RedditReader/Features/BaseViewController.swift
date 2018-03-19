//
//  BaseViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

/// Base class for UIViewControllers that are used in the app. Conforms to Presenter protocol
public class BaseViewController: UIViewController {

    private var activityIndicator: UIActivityIndicatorView!
    private lazy var alertBuilder = AlertControllerBuilder()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }

    private func setupDesign() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)
        activityIndicator.centerIn(view)
    }

}

extension BaseViewController: Presenter {

    public func displayAlert(for type: AlertType) {
        let alertController = alertBuilder.build(from: type)
        present(alertController, animated: true, completion: nil)
    }

    public func present(controller: Presenter, navigationType: NavigationType) {
        guard let controller = controller as? UIViewController else {
            return
        }
        switch navigationType {
        case .modal:
            present(controller, animated: true, completion: nil)
        case .push:
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    public func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    public func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }

}
