//
//  OrderCoordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 23.05.2024.
//

import UIKit

class OrderCoordinator: Coordinator, MenuItemDetailViewControllerDelegate {
    
    var order = Order(items: [])
    private let factory = SceneFactory.self

    override func start() {
        showOrder()
    }
    
    func didAddToOrder(menuItem: MenuItem) {
        order.items.append(menuItem)
        print(order)
        if let orderViewController = navigationController?.topViewController as? OrderViewController {
            orderViewController.presenter.addItem(menuItem)
        }
    }
    
    override func finish() {
        print("OrderCoordinator finish")
    }
}

// MARK: - Navigation
extension OrderCoordinator {
    func showOrder() {
        guard let navigationController = navigationController else { return }
        let vc = factory.makeOrderScene(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
