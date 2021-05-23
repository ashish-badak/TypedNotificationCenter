//
//  NotificationPayloads.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

/// Each notification data object should conform to this protocol, to make it easy to map Notification to intended data type
protocol NotificationPayload {
    init?(_ notification: Notification)
}

extension NotificationPayload {
    init?(_ notification: Notification) {
        
        /// - Note: Setting data in "value" key while posting notification, so extracting in the same way here.
        if let userInfo: [AnyHashable: Any] = notification.userInfo,
           let notificationPayload: Self = userInfo["value"] as? Self {
            self = notificationPayload
        } else {
            return nil
        }
    }
}

/// - NOTE: Added this extension so that notification observer callback which do not need any data can expect original `Notification` object back as it is.
extension Notification: NotificationPayload {
    init?(_ notification: Notification) {
        self = notification
    }
}
