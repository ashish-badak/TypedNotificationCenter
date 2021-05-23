//
//  SecondViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class SecondViewController: UIViewController {
    let nextButton = UIButton.getButton(title: "Kill Dany")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kings Landing"
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
        NotificationCenter.default.addObserver(name: .theLongNightNotification) { [weak self] _ in
            self?.view.backgroundColor = .black
        }
    }
    
    @objc func goNext() {
        NotificationCenter.default.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .killedDany)
        )
        
        self.navigationController?.pushViewController(ThirdViewController(), animated: true)
    }
}
