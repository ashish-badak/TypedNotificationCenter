# TypedNotificationCenter
Notification Center Wrapper which allows us to deal with typed data instead of just Dictionary

**Observe notification as:
**
1. When you expect data:

```
TypedNotificationCenter.addObserver(name: .achievementNotification, forType: AchievementNotificationPayload.self) {
    [weak self] achievement in
    /// Do your stuff here
}
```

2. When you do not expect data (or want Notification object back):
```
TypedNotificationCenter.addObserver(name: .theLongNightNotification, forType: Notification.self) {
    [weak self] notificationPayload in
    /// Do your stuff here
}
```
 
3. You can skip Notification.self all together when you don't expect data:
```
TypedNotificationCenter.addObserver(name: .theLongNightNotification) {
    [weak self] _ in
    /// Do your stuff here
}
```


**Post notification as:
**

1. When you have data to be passed:
```
TypedNotificationCenter.post(
    name: .achievementNotification,
    payload: AchievementNotificationPayload(achievement: .becameLordCommander)
)
```

2. When you no data to be passed:

```
TypedNotificationCenter.post(
    name: .theLongNightNotification,
    payload: nil
)
```


When you want to pass your object as payload make sure it is conforming to *NotificationPayload* as:
```
struct AchievementNotificationPayload: NotificationPayload {
    /// ...
}
```
