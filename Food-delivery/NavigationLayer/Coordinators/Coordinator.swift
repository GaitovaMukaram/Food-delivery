//
//  Coordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

enum CoordinatorType {
    case app
    case onboarding
    case login
    case home
    case cart
    case order
    case profile
}

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var type: CoordinatorType { get }
    var navigationController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    func finish()
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators.append(childCoordinator)
    }
    func removeChildCoordinator(_ childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter{ $0 !== childCoordinator }
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

protocol TabBarCoordinator: AnyObject, CoordinatorProtocol{
    var tabBarController: UITabBarController? { get set }
}

class Coordinator: CoordinatorProtocol {
    var childCoordinators: [any CoordinatorProtocol] = []
    var type: CoordinatorType
    var navigationController: UINavigationController?
    var window: UIWindow?
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    
    init(childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](), type: CoordinatorType, navigationController: UINavigationController, finishDelegate: (any CoordinatorFinishDelegate)? = nil, window: UIWindow? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
        self.window = window
    }
    
    deinit {
        print("Coordinator deinited \(type)")
        childCoordinators.forEach { $0.finishDelegate = nil }
        childCoordinators.removeAll()
    }
    
    func start() {
        print("Coordinator start")
    }
    
    func finish() {
        print("Coordinator finish")
    }
    
    
}
