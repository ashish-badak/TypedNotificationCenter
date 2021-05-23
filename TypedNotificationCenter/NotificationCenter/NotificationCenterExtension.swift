//
//  NotificationCenterExtension.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

extension NotificationCenter {
    @discardableResult func addObserver<N: NotificationPayload> (
        name: Notification.Name,
        forType: N.Type,
        then callback: @escaping (N?) -> Void
    ) -> NSObjectProtocol {
        addObserver(
            forName: name,
            object: nil,
            queue: .current
        ) { notification in
            let payload = N(notification)
            callback(payload)
        }
    }
    
    @discardableResult func addObserver(
        name: Notification.Name,
        then callback: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        addObserver(
            forName: name,
            object: nil,
            queue: .current
        ) { notification in
            callback(notification)
        }
    }
    
    func post(name: Notification.Name, payload: NotificationPayload?) {
        if let payload: NotificationPayload = payload {
            post(name: name, object: nil, userInfo: ["value": payload])
        } else {
            post(name: name, object: nil, userInfo: nil)
        }
    }
}
