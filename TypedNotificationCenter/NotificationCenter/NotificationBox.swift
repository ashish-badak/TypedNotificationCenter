//
//  NotificationBox.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import Foundation

final class NotificationBox {
    private var observers: [Notification.Name: NSObjectProtocol]
    
    init(observers: [Notification.Name: NSObjectProtocol] = [:]) {
        self.observers = observers
    }
    
    func addObserver(_ observer: NSObjectProtocol, forKey key: Notification.Name) {
        observers[key] = observer
    }
    
    func removeObserver(forKey key: Notification.Name ) {
        observers.removeValue(forKey: key)
    }
    
    func removeAllObservers() {
        observers.values.forEach { NotificationCenter.default.removeObserver($0) }
    }
    
    deinit {
        removeAllObservers()
    }
}
