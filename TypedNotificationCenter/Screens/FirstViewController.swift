//
//  FirstViewController.swift
//  TypedNotificationCenter
//
//  Created by Ashish Badak on 19/05/21.
//

import UIKit

final class FirstViewController: UIViewController {
    private let nextButton = UIButton.getButton(title: Constants.ButtonTitles.fightWar)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ScreenTitles.wall
        setupUI()
        setupObservers()
        
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupObservers() {
        TypedNotificationCenter.addObserver(name: .theLongNightNotification) { [weak self] _ in
            UIView.animate(withDuration: 0.25) {
                self?.view.backgroundColor = .black
            }
        }
    }
    
    @objc private func goNext() {
        TypedNotificationCenter.post(
            name: .achievementNotification,
            payload: AchievementNotificationPayload(achievement: .faughtAtTheGreatWar)
        )
        
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
}
