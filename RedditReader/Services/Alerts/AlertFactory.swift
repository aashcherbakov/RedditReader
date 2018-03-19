//
//  AlertFactory.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/18/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

/// Types of possible alerts
public enum AlertType {

    case notification(title: String?, message: String?)
    case error(message: String?)

}

/// Display for alert
public protocol AlertDisplay {

    /// Title for alert
    var title: String? { get }

    /// Alert message
    var message: String? { get }

}

/// Class responsible for creating AlertDisplays
public class AlertFactory {

    /// Creates display for provided AlertType
    func createDisplay(for alertType: AlertType) -> AlertDisplay {
        switch alertType {
        case .error(let message):
            return ErrorAlertDisplay(message: message)
        case .notification(let title, let message):
            return NotificationAlertDisplay(message: message, title: title)
        }
    }

}

/// Display for alerts of Error type
public struct ErrorAlertDisplay: AlertDisplay {

    public let title: String?
    public let message: String?

    init(message: String?, title: String? = "Error") {
        self.message = message
        self.title = title
    }

}

/// Display for alert of Notification type
public struct NotificationAlertDisplay: AlertDisplay {

    public let title: String?
    public let message: String?

    init(message: String?, title: String?) {
        self.message = message
        self.title = title
    }

}
