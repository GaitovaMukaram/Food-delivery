//
//  ProfileCoordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
//        finisDelegate?.coordinatorDidFinish(childCoordinator: self)
        print("AppCoordinator finish")
    }
    
     
}
