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
        // Здесь вы можете загрузить данные профиля из модели или сервиса
        let profile = Profile(name: "Dude", phoneNumber: "+7 123 456 78 90", avatarImage: UIImage(named: "avatar"))
        view?.updateProfile(profile)
        
        // Настройка опций профиля
        let options = [
            ProfileOption(title: "My Profile") { [weak self] in
                self?.coordinator?.showMyProfile()
            },
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
