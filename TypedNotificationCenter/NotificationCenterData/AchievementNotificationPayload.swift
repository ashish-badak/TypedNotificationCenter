//
//  AchievementNotificationPayload.swift
//  TypedNotificationCenter
//
//  Created by Ashish B on 23/05/21.
//

import Foundation

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
