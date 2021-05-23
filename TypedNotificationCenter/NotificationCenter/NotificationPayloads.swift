//
//  NotificationPayloads.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation


struct NotificationDescriptor<N: NotificationPayload> {
    let name: Notification.Name
    func convert(_ notification: Notification) -> N? {
        N(notification)
    }
}


/// Each notification data object should conform to this protocol, to make it easy to map Notification to intended data type
protocol NotificationPayload {
    init?(_ notification: Notification)
}

extension NotificationPayload {
    init?(_ notification: Notification) {
        if let userInfo: [AnyHashable: Any] = notification.userInfo,
           let notificationPayload: Self = userInfo["value"] as? Self {
            self = notificationPayload
        } else {
            return nil
        }
    }
}

extension Notification: NotificationPayload {
    init?(_ notification: Notification) {
        self = notification
    }
}

struct LongNightNotificationPayload: NotificationPayload {
    var hasNightArrived: Bool
}
