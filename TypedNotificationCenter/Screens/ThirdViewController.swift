//
//  ThirdViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class ThirdViewController: UIViewController {
    let changeThemeButton = UIButton.getButton(title: "Explore The Long Night")
    
    let notificationBox = NotificationBox()
    
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
        let themeChangeObserver = NotificationCenter.default.addObserver(
            descriptor: NotificationDescriptor<LongNightNotificationPayload>(name: .theLongNightNotification)
        ) { [weak self] (notificationPayload) in
            self?.view.backgroundColor = .black
        }
        
        notificationBox.addObserver(themeChangeObserver, forKey: .theLongNightNotification)
    }
    
    @objc func changeTheme() {
        NotificationCenter.default.post(
            name: .theLongNightNotification,
            payload: LongNightNotificationPayload(hasNightArrived: true)
        )
    }
}
