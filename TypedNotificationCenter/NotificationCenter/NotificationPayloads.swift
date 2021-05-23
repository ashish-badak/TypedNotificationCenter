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

enum Achievement {
    case becameLordCommander
    case faughtAtTheGreatWar
    case killedDany
    case achievedEverything
    
    var brag: String {
        switch self {
        case .becameLordCommander:  return "If I fall don't bring me back"
        case .faughtAtTheGreatWar:  return "I stuck them with the pointy end"
        case .killedDany:           return "I am a King"
        case .achievedEverything:   return "I Do Know Some Things"
        }
    }
}

struct AchievementNotificationPayload: NotificationPayload {
    let achievement: Achievement
}
