//
//  MainViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class MainViewController: UIViewController {
    private var achievementLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var responseLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        return label
    }()
    
    let nextButton = UIButton.getButton(title: "Be The Lord Commander")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let notificationManager = SimpleNotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Winterfell"
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(achievementLabel)
        stackView.addArrangedSubview(responseLabel)
        stackView.addArrangedSubview(nextButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        responseLabel.text = "You Know Nothing"
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        setupObserver()
    }
    
    func setupObserver() {
        notificationManager.addObservers()
        notificationManager.whenTheLongNightArrives = { [weak self] (payload) in
            self?.view.backgroundColor = .black
            self?.achievementLabel.textColor = .white
            self?.responseLabel.textColor = .white
        }
        
        notificationManager.whenAchieves = { [weak self] achievementPayload in
            self?.achievementLabel.text = achievementPayload.achievement.brag
        }
    }
    
    @objc func goNext() {
        NotificationCenter.default.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .becameLordCommander)
        )
        
        self.navigationController?.pushViewController(FirstViewController(), animated: true)
    }
}
