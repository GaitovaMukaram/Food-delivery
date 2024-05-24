//
//  OnboardingViewPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import Foundation

protocol OnboardingViewOutput: AnyObject {
    func onboardingFinish()
}

class OnboardingViewPresenter: OnboardingViewOutput {
    // MARK: - Properties
    private var userStorage = UserStorage.shared
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        self.coordinator = coordinator
    }
    
    func onboardingFinish() {
        userStorage.passedOnboarding = true
        coordinator.finish()
    }
}

