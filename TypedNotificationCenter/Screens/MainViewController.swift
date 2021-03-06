//
//  MainViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

final class MainViewController: UIViewController {
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
    
    private let nextButton = UIButton.getButton(title: Constants.ButtonTitles.lordCommander)
    private let resetButton = UIButton.getButton(title: Constants.ButtonTitles.reset)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let notificationManager = MainViewNotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ScreenTitles.home
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(achievementLabel)
        stackView.addArrangedSubview(responseLabel)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(resetButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        responseLabel.text = "You Know Nothing"
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.isHidden = true
        setupObserver()
    }
    
    private func setupObserver() {
        notificationManager.addObservers()
        notificationManager.whenTheLongNightArrives = { [weak self] (payload) in
            guard let self = self else {
                return
            }
            
            UIView.animate(withDuration: 0.25) {
                self.view.backgroundColor = .black
                self.achievementLabel.textColor = .white
                self.responseLabel.textColor = .white
            }
            
            self.nextButton.isHidden = true
            self.resetButton.isHidden = false
        }
        
        notificationManager.whenAchieves = { [weak self] achievementPayload in
            self?.achievementLabel.text = achievementPayload.achievement.brag
        }
    }
    
    @objc private func goNext() {
        TypedNotificationCenter.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .becameLordCommander)
        )
        
        self.navigationController?.pushViewController(FirstViewController(), animated: true)
    }
    
    @objc private func reset() {
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = .white
            self.achievementLabel.textColor = .black
            self.responseLabel.textColor = .black
        }
        
        self.nextButton.isHidden = false
        self.resetButton.isHidden = true
        self.achievementLabel.text = ""
    }
}
