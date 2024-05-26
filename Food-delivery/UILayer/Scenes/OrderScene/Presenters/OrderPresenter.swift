//
//  OrderPresenter.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

protocol OrderView: AnyObject {
    func updateOrderItems()
}

class OrderPresenter {
    weak var view: OrderView?
    var coordinator: OrderCoordinator?

    init(coordinator: OrderCoordinator) {
        self.coordinator = coordinator
    }
    
    var orderItems: [MenuItem] {
        return coordinator?.order.items ?? []
    }
    
    func viewDidLoad() {
        view?.updateOrderItems()
    }
    
    func addItem(_ item: MenuItem) {
        coordinator?.order.items.append(item)
        view?.updateOrderItems()
    }
}


