//
//  SceneFactory.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 24.05.2024.
//

import UIKit


struct SceneFactory {
    
    // MARK: - Onboarding flow
    
    static func makeOnboardingFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate, navigationController: UINavigationController) -> OnboardingCoordinator {
        let onboardingCoordinator = OnboardingCoordinator(type: .onboarding, navigationController: navigationController, finishDelegate: finishDelegate)
        coordinator.addChildCoordinator(onboardingCoordinator)
        return onboardingCoordinator
    }
    
    static func makeLoginFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate, navigationController: UINavigationController) -> LoginCoordinator {
        let loginCoordinator = LoginCoordinator(type: .login, navigationController: navigationController, finishDelegate: finishDelegate)
        coordinator.addChildCoordinator(loginCoordinator)
        return loginCoordinator
    }
    
    static func makeOnboardingScene(coordinator: OnboardingCoordinator) -> OnboardingViewController {
        var pages = [OnboardingPartViewController]()
        
        let firstVC = OnboardingPartViewController()
        firstVC.imageToShow = UIImage(resource: .chickenLeg)
        firstVC.titleText = "Delicious Food"
        firstVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        firstVC.buttonText = "Next"
       
        let secondVC = OnboardingPartViewController()
        secondVC.imageToShow = UIImage(resource: .shipped)
        secondVC.titleText = "Fast Shipping"
        secondVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        secondVC.buttonText = "Next"
        
        let thirdVC = OnboardingPartViewController()
        thirdVC.imageToShow = UIImage(resource: .medal)
        thirdVC.titleText = "Certificate Food"
        thirdVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        thirdVC.buttonText = "Next"
        
        let fourthVC = OnboardingPartViewController()
        fourthVC.imageToShow = UIImage(resource: .creditCard)
        fourthVC.titleText = "Payment Online"
        fourthVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        fourthVC.buttonText = "Cool!"
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        pages.append(fourthVC)
        
        let presenter = OnboardingViewPresenter(coordinator: coordinator)
        let viewController = OnboardingViewController(pages: pages, viewOutout: presenter)
        
        return viewController
    }
    
    // MARK: - Main flow
    static func makeMainFlow(coordinator: AppCoordinator, finishDelegate: CoordinatorFinishDelegate) -> TabBarController {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(type: .home, navigationController: homeNavigationController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(resource: .home), tag: 0)
        homeCoordinator.finishDelegate = finishDelegate
        homeCoordinator.start()
        
        let cartNavigationController = UINavigationController()
        let cartCoordinator = CartCoordinator(type: .cart, navigationController: cartNavigationController)
        cartNavigationController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(resource: .cart), tag: 1)
        cartCoordinator.finishDelegate = finishDelegate
        cartCoordinator.start()
        
        let listNavigationController = UINavigationController()
        let listCoordinator = ListCoordinator(type: .order, navigationController: listNavigationController)
        listNavigationController.tabBarItem = UITabBarItem(title: "My List", image: UIImage(resource: .order), tag: 2)
        listCoordinator.finishDelegate = finishDelegate
        listCoordinator.start()
        
        let profileNavigationController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(type: .profile, navigationController: profileNavigationController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(resource: .profile), tag: 3)
        profileCoordinator.finishDelegate = finishDelegate
        profileCoordinator.start()
        
        coordinator.addChildCoordinator(homeCoordinator)
        coordinator.addChildCoordinator(cartCoordinator)
        coordinator.addChildCoordinator(listCoordinator)
        coordinator.addChildCoordinator(profileCoordinator)
        
        let tabBarControllers = [homeNavigationController, cartNavigationController, listNavigationController, profileNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        return tabBarController
    }
    
    static func makeAuthScene(coordinator: LoginCoordinator) -> LoginViewController {
        let presenter = LoginPresenter(coordinator: coordinator)
        let controller = LoginViewController(viewOutput: presenter, state: .initial)
        presenter.viewInput = controller
        return controller
    }
    
    static func makeSignInScene(coordinator: LoginCoordinator) -> LoginViewController {
        let presenter = LoginPresenter(coordinator: coordinator)
        let controller = LoginViewController(viewOutput: presenter, state: .signIn)
        presenter.viewInput = controller
        return controller
    }
    
    static func makeSignUpScene(coordinator: LoginCoordinator) -> LoginViewController {
        let presenter = LoginPresenter(coordinator: coordinator)
        let controller = LoginViewController(viewOutput: presenter, state: .signUp)
        presenter.viewInput = controller
        return controller
    }
    
    static func makeHomeScene(coordinator: HomeCoordinator) -> HomeViewController {
        let presenter = HomePresenter()
        let controller = HomeViewController(presenter: presenter)
        presenter.view = controller
        presenter.coordinator = coordinator
        return controller
    }
    
    static func makeMenuItemDetailScene(menuItem: MenuItem) -> MenuItemDetailViewController {
            return MenuItemDetailViewController(menuItem: menuItem)
        }

        static func makeCartScene(coordinator: CartCoordinator, cart: Cart) -> CartViewController {
            let viewController = CartViewController()
            let presenter = CartPresenter(view: viewController, cart: cart)
            viewController.presenter = presenter
            return viewController
        }
    
    static func makeProfileScene(coordinator: ProfileCoordinator) -> ProfileViewController {
            let presenter = ProfilePresenter(coordinator: coordinator)
            let controller = ProfileViewController(presenter: presenter)
            presenter.view = controller
            return controller
        }
    
    static func makePaymentSettingsScene() -> PaymentSettingsViewController {
        return PaymentSettingsViewController()
    }
    
    static func makeAddCreditCardScene() -> AddCreditCardViewController {
        return AddCreditCardViewController()
    }
}
