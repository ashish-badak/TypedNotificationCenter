//
//  NotificationCenterExtension.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

fileprivate extension NotificationCenter {
    @discardableResult func addObserver<N: NotificationPayload> (
        name: Notification.Name,
        forType: N.Type,
        queue: OperationQueue? = .current,
        then callback: @escaping (N?) -> Void
    ) -> NSObjectProtocol {
        addObserver(
            forName: name,
            object: nil,
            queue: queue
        ) { notification in
            let payload = N(notification)
            callback(payload)
        }
    }
    
    @discardableResult func addObserver(
        name: Notification.Name,
        queue: OperationQueue? = .current,
        then callback: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        addObserver(
            forName: name,
            object: nil,
            queue: queue
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

final class TypedNotificationCenter {
    private static let center = NotificationCenter.default
    
    @discardableResult
    static func addObserver<N: NotificationPayload> (
        name: Notification.Name,
        forType type: N.Type,
        queue: OperationQueue? = .current,
        then callback: @escaping (N?) -> Void
    ) -> NSObjectProtocol {
        
        center.addObserver(name: name, forType: type, queue: queue, then: callback)
    }
    
    @discardableResult
    static func addObserver(
        name: Notification.Name,
        queue: OperationQueue? = .current,
        then callback: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        
        center.addObserver(name: name, queue: queue, then: callback)
    }
    
    static func post(name: Notification.Name, payload: NotificationPayload?) {
        center.post(name: name, payload: payload)
    }
}
