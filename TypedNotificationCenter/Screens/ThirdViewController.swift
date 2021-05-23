//
//  ThirdViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

class ThirdViewController: UIViewController {
    let changeThemeButton = UIButton.getButton(title: "Explore The Long Night")
    
    private var responseLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.text = "The Night is Dark & Full of Terrors..."
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Beyond The Wall"
        setupUI()
        setupObservers()
        changeThemeButton.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(changeThemeButton)
        stackView.addArrangedSubview(responseLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(
            name: .theLongNightNotification,
            forType: LongNightNotificationPayload.self
        ) { [weak self] (notificationPayload) in
            guard let self = self else { return }
            
            self.view.backgroundColor = .black
            self.changeThemeButton.isHidden = true
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
