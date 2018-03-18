//
//  Presenter.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation

/// Protocol that describes a base functionality of BaseViewController
public protocol Presenter: class {

    /// Shows activity indicator
    func showActivityIndicator()

    /// Hides activity indicator
    func hideActivityIndicator()

    /// Presents given ViewController
    ///
    /// - Parameters:
    ///   - controller: controller that conforms to Presenter protocol
    ///   - navigationType: NavigationType enum value
    func present(controller: Presenter, navigationType: NavigationType)

}
