//
//  ProfilePresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

protocol ProfileView: AnyObject {
    func updateProfile(_ profile: User)
    func updateOptions(_ options: [ProfileOption])
}

class ProfilePresenter {
    weak var view: ProfileView?
    private var coordinator: ProfileCoordinator?
    private var user: User

    init(coordinator: ProfileCoordinator, user: User) {
        self.coordinator = coordinator
        self.user = user
    }

    func viewDidLoad() {
        // Используем данные пользователя для обновления профиля
        let profile = User(name: user.name, email: user.email, avatarImage: user.avatarImage)
        view?.updateProfile(profile)

        // Настройка опций профиля
        let options = [
            ProfileOption(title: "Change Password") { [weak self] in
                self?.coordinator?.showChangePassword()
            },
            ProfileOption(title: "Payment Settings") { [weak self] in
                self?.coordinator?.showPaymentSettings()
            },
            ProfileOption(title: "My Voucher") { [weak self] in
                self?.coordinator?.showMyVoucher()
            },
            ProfileOption(title: "Notification") { [weak self] in
                self?.coordinator?.showNotification()
            },
            ProfileOption(title: "About Us") { [weak self] in
                self?.coordinator?.showAboutUs()
            },
            ProfileOption(title: "Contact Us") { [weak self] in
                self?.coordinator?.showContactUs()
            }
        ]
        view?.updateOptions(options)
    }
}

