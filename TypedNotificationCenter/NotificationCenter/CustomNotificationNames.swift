//
//  NotificationNames.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

extension Notification.Name {
    /// - NOTE: All custom notifications name can be stored here to avoid strings elsewhere
    static var achievementNotification: Self { .init("achievementNotification") }
    static var theLongNightNotification: Self { .init("theLongNightNotification") }
}
