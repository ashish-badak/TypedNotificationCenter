//
//  ThirdViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

final class ThirdViewController: UIViewController {
    private let changeThemeButton = UIButton.getButton(title: "Explore The Long Night")
    
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
    
    private func setupUI() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(changeThemeButton)
        stackView.addArrangedSubview(responseLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupObservers() {
        TypedNotificationCenter.addObserver(
            name: .theLongNightNotification,
            forType: Notification.self
        ) { [weak self] _ in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.25) {
                self.view.backgroundColor = .black
            }
            self.changeThemeButton.isHidden = true
        }
    }
    
    @objc private func changeTheme() {
        TypedNotificationCenter.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .achievedEverything)
        )
        
        TypedNotificationCenter.post(name: .theLongNightNotification, payload: nil)
    }
}
