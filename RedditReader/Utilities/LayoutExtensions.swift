//
//  LayoutExtensions.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public extension UIView {

    private func prepareForProgrammaticLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    public func embedIn(_ view: UIView) {
        prepareForProgrammaticLayout()

        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    public func centerIn(_ view: UIView) {
        prepareForProgrammaticLayout()

        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func alignLeftWith(_ view: UIView) {
        prepareForProgrammaticLayout()

        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }

    public func alignRightWith(_ view: UIView) {
        prepareForProgrammaticLayout()

        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    public func alignYWith(_ view: UIView) {
        prepareForProgrammaticLayout()

        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func matchHightWith(_ view: UIView) {
        prepareForProgrammaticLayout()

        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

}
