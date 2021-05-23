//
//  FirstViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class FirstViewController: UIViewController {
    let nextButton = UIButton.getButton(title: "Fight The Great War")
    
    let notificationManager = SimpleNotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The Wall"
        setupUI()
        setupObservers()
        
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupObservers() {
        notificationManager.addObservers()
        notificationManager.whenTheLongNightArrives = { [weak self] (payload) in
            self?.view.backgroundColor = .black
        }
    }
    
    @objc func goNext() {
        NotificationCenter.default.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .faughtAtTheGreatWar)
        )
        
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
}
