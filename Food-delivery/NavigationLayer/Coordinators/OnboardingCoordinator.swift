//
//  OnboardingCoordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finis() {
//        finisDelegate?.coordinatorDidFinish(childCoordinator: self)
        print("AppCoordinator finish")
    }
    
     
}
