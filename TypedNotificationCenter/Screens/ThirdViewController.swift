//
//  ThirdViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class ThirdViewController: UIViewController {
    let changeThemeButton = UIButton.getButton(title: "Explore The Long Night")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Beyond The Wall"
        setupUI()
        setupObservers()
        changeThemeButton.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(changeThemeButton)
        NSLayoutConstraint.activate([
            changeThemeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeThemeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(
            name: .theLongNightNotification,
            forType: LongNightNotificationPayload.self
        ) { [weak self] (notificationPayload) in
            self?.view.backgroundColor = .black
        }
    }
    
    @objc func changeTheme() {
        NotificationCenter.default.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .achievedEverything)
        )
        
        NotificationCenter.default.post(
            name: .theLongNightNotification,
            payload: LongNightNotificationPayload(hasNightArrived: true)
        )
    }
}
