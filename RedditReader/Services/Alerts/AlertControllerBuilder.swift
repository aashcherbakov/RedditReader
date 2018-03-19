//
//  AlertControllerBuilder.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/18/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class AlertControllerBuilder {

    private let displayFactory = AlertFactory()

    func build(from alertType: AlertType) -> UIAlertController {
        let display = displayFactory.createDisplay(for: alertType)
        let controller = UIAlertController(
            title: display.title,
            message: display.message,
            preferredStyle: .alert
        )

        controller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        return controller
    }

}
