//
//  ProfilePresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

protocol ProfileView: AnyObject {
    func updateProfile(_ profile: Profile)
    func updateOptions(_ options: [ProfileOption])
}

class ProfilePresenter {
    weak var view: ProfileView?
    private var coordinator: ProfileCoordinator?

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }

    func viewDidLoad() {
        let profile = Profile(name: "None", email: "None")
        view?.updateProfile(profile)

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

