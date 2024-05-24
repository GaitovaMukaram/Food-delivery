//
//  OnboardingViewPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import Foundation

protocol OnboardingViewOutPut: AnyObject {
    func onboardingFinish()
}

class OnboardingViewPresenter: OnboardingViewOutPut {
    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator!
    
    init(coordinator: OnboardingCoordinator!) {
        self.coordinator = coordinator
    }
    
    func onboardingFinish() {
        coordinator.finish()
    }
}

