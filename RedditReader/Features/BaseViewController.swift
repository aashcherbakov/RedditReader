//
//  BaseViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    private var activityIndicator: UIActivityIndicatorView!

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

    public func present(controller: Presenter, navigationType: NavigationType) {
        guard let controller = controller as? UIViewController else {
            return
        }
        switch navigationType {
        case .modal:
            present(controller, animated: true, completion: nil)
        case .push:
            controller.navigationController?.pushViewController(controller, animated: true)
        }
    }

    public func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    public func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }

}
