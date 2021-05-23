//
//  NotificationCenterExtension.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

extension NotificationCenter {
    func addObserver<N: NotificationPayload> (
        descriptor: NotificationDescriptor<N>,
        then callback: @escaping (N?) -> Void
    ) -> NSObjectProtocol {
        addObserver(
            forName: descriptor.name,
            object: nil,
            queue: .current
        ) { notification in
            let payload = descriptor.convert(notification)
            callback(payload)
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
