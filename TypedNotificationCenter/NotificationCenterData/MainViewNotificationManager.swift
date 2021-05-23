//
//  MainViewNotificationManager.swift
//  TypedNotificationCenter
//
//  Created by Ashish B on 23/05/21.
//

import Foundation

/// - NOTE: This class depicts an extra step of code separation. Using this kind of structure we can completely free our controller classes or view models from duty of notification implementation. Controller / View models will only have to perform tasks on closures.
final class MainViewNotificationManager: NotificationManager {
    var whenTheLongNightArrives: ((Notification?) -> Void)?
    var whenAchieves: ((AchievementNotificationPayload) -> Void)?
    
    func addObservers() {
        TypedNotificationCenter.addObserver(name: .theLongNightNotification, forType: Notification.self) {
            [weak self] notificationPayload in
            self?.whenTheLongNightArrives?(notificationPayload)
        }
        
        TypedNotificationCenter.addObserver(name: .achievementNotification, forType: AchievementNotificationPayload.self) {
            [weak self] achievement in
            
            if let achievement = achievement {
                self?.whenAchieves?(achievement)
            }
        }
    }
}
