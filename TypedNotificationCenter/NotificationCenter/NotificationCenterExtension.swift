//
//  NotificationCenterExtension.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

/// - Note: Made this `fileprivate` as only `TypedNotificationCenter` is supposed to use these extension functions.
///     If one wish to create custom  `NotificationCenter` object and use these functions then `fileprivate` keyword can be removed.
fileprivate extension NotificationCenter {
    
    /// Adds observer for a particular notification and notifies event with passing typed data back.
    /// - Parameters:
    ///   - name: The name of the notification to register for delivery to the observer block. Specify a notification name to deliver only entries with this notification name.
    ///   - forType: notification payload type which observer expects back.
    ///   - queue: The operation queue where the block runs. When nil, the block runs synchronously on the posting thread.
    ///   - callback: The block that executes when receiving a notification. The notification center copies the block. The block takes one argument: the notification payload.
    /// - Returns: An opaque object to act as the observer.
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
    
    /// Adds observer for a particular notification and notifies event with passing `Notification` object back.
    /// - Parameters:
    ///   - name: The name of the notification to register for delivery to the observer block. Specify a notification name to deliver only entries with this notification name.
    ///   - queue: The operation queue where the block runs. When nil, the block runs synchronously on the posting thread.
    ///   - callback: The block that executes when receiving a notification. The notification center copies the block. The block takes one argument: the notification object.
    /// - Returns: An opaque object to act as the observer.
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
    
    /// Creates a notification with a given name, and notification payload object and posts it to the notification center.
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - payload: Instance which contains notification data to be passed around. Instance type should conform to NotificationPayload protocol
    func post(name: Notification.Name, payload: NotificationPayload?) {
        if let payload: NotificationPayload = payload {
            post(name: name, object: nil, userInfo: ["value": payload])
        } else {
            post(name: name, object: nil, userInfo: nil)
        }
    }
}


/// A wrapper class which can be used to observe and post notifications instead of using `NotificationCenter` directly.
final class TypedNotificationCenter {
    /// Note: We use `NotificationCenter.default` mostly to deal with notifications so using it directly here.
    private static let center = NotificationCenter.default
    
    /// Adds observer for a particular notification and notifies event with passing typed data back. Uses `NotificationCenter.default`
    /// - Parameters:
    ///   - name: The name of the notification to register for delivery to the observer block. Specify a notification name to deliver only entries with this notification name.
    ///   - forType: notification payload type which observer expects back.
    ///   - queue: The operation queue where the block runs. When nil, the block runs synchronously on the posting thread.
    ///   - callback: The block that executes when receiving a notification. The notification center copies the block. The block takes one argument: the notification payload.
    /// - Returns: An opaque object to act as the observer.
    @discardableResult
    static func addObserver<N: NotificationPayload> (
        name: Notification.Name,
        forType type: N.Type,
        queue: OperationQueue? = .current,
        then callback: @escaping (N?) -> Void
    ) -> NSObjectProtocol {
        
        center.addObserver(name: name, forType: type, queue: queue, then: callback)
    }
    
    /// Adds observer for a particular notification and notifies event with passing `Notification` object back. Uses `NotificationCenter.default`
    /// - Parameters:
    ///   - name: The name of the notification to register for delivery to the observer block. Specify a notification name to deliver only entries with this notification name.
    ///   - queue: The operation queue where the block runs. When nil, the block runs synchronously on the posting thread.
    ///   - callback: The block that executes when receiving a notification. The notification center copies the block. The block takes one argument: the notification object.
    /// - Returns: An opaque object to act as the observer.
    @discardableResult
    static func addObserver(
        name: Notification.Name,
        queue: OperationQueue? = .current,
        then callback: @escaping (Notification) -> Void
    ) -> NSObjectProtocol {
        
        center.addObserver(name: name, queue: queue, then: callback)
    }
    
    /// Creates a notification with a given name, and notification payload object and posts it to the notification center using `NotificationCenter.default`.
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - payload: Instance which contains notification data to be passed around. Instance type should conform to NotificationPayload protocol
    static func post(name: Notification.Name, payload: NotificationPayload?) {
        center.post(name: name, payload: payload)
    }
}
