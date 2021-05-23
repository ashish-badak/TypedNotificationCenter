//
//  NotificationManager.swift
//  TypedNotificationCenter
//
//  Created by Ashish B on 23/05/21.
//

import Foundation

protocol NotificationManager {
    var notificationBox: NotificationBox { get set }
    func addObservers()
}

final class SimpleNotificationManager: NotificationManager {
    var notificationBox: NotificationBox = NotificationBox()
    var whenTheLongNightArrives: ((Notification?) -> Void)?
    
    func addObservers() {
        let observer = NotificationCenter.default.addObserver(
            descriptor: NotificationDescriptor<Notification>(name: .theLongNightNotification)
        ) { [weak self] (notificationPayload) in
            self?.whenTheLongNightArrives?(notificationPayload)
        }
        notificationBox.addObserver(observer, forKey: .theLongNightNotification)
    }
}
