//
//  SecondViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class SecondViewController: UIViewController {
    let nextButton = UIButton.getButton(title: "Kill Dany")
    
    let notificationBox = NotificationBox()
    
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
        let themeChangeObserver = NotificationCenter.default.addObserver(
            descriptor: NotificationDescriptor<Notification>(name: .theLongNightNotification)
        ) { [weak self] (notificationPayload) in
            self?.view.backgroundColor = .black
        }
        
        notificationBox.addObserver(themeChangeObserver, forKey: .theLongNightNotification)
    }
    
    @objc func goNext() {
        self.navigationController?.pushViewController(ThirdViewController(), animated: true)
    }
}
