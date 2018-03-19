//
//  LayoutExtensions.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public extension UIView {

    /// Centers self in provided view
    public func centerIn(_ view: UIView) {
        prepareForProgrammaticLayout()

        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Private functions

    private func prepareForProgrammaticLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

}
