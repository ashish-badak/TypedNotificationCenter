//
//  NotificationManager.swift
//  TypedNotificationCenter
//
//  Created by Ashish B on 23/05/21.
//

import Foundation

protocol NotificationManager {
    func addObservers()
}

final class SimpleNotificationManager: NotificationManager {
    var whenTheLongNightArrives: ((Notification?) -> Void)?
    
    func addObservers() {
        NotificationCenter.default.addObserver(name: .theLongNightNotification, forType: Notification.self) {
            [weak self] notificationPayload in
            self?.whenTheLongNightArrives?(notificationPayload)
        }
    }
}
