//
//  AppCoordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let userStorage = UserStorage.shared
    private let factory = SceneFactory.self
    
    override func start() {
//        if userStorage.passedOnboarding {
//            showAuthFlow()
//        } else {
//            showOnboardingFlow()
//        }
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
    
    
}

// MARK: - Navigation methods

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = factory.makeOnboardingFlow(coordinator: self, finishDelegate: self, navigationController: navigationController)
        onboardingCoordinator.start()
    }
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        let tabBarController = factory.makeMainFlow(coordinator: self, finishDelegate: self)
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func showAuthFlow() {
        guard let navigationController = navigationController else { return }
        let loginCoordinator = factory.makeLoginFlow(coordinator: self, finishDelegate: self, navigationController: navigationController)
        loginCoordinator.start()
    }
}

// MARK: - CoordinatorFinishDelegate
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .onboarding:
            showAuthFlow()
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()]
        case .login:
            showMainFlow()
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()]
        case .app:
            return
        default:
            navigationController?.popToRootViewController(animated: false)
        }
    }
}
