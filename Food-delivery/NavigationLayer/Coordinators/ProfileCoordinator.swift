//
//  ProfileCoordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    private let factory = SceneFactory.self

    override func start() {
        showProfile()
    }
    
    func showProfile() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeProfileScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("ProfileCoordinator finish")
    }
    
    func showMyProfile() {
        // Код для отображения экрана "My Profile"
    }
    
    func showChangePassword() {
        let changePasswordVC = ChangePasswordViewController()
        navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    func showPaymentSettings() {
        let paymentSettingsVC = PaymentSettingsViewController()
        navigationController?.pushViewController(paymentSettingsVC, animated: true)
    }
    
    func showMyVoucher() {
        // Код для отображения экрана "My Voucher"
    }
    
    func showNotification() {
        // Код для отображения экрана "Notification"
    }
    
    func showAboutUs() {
        // Код для отображения экрана "About Us"
    }
    
    func showContactUs() {
        // Код для отображения экрана "Contact Us"
    }
}

