//
//  CartCoordinator.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 27.05.2024.
//

import UIKit

class CartCoordinator: Coordinator {

    private let factory = SceneFactory.self
    
    override func start() {
        showCartScene()
    }
    
    override func finish() {
        print("CartCoordinator finish")
    }
     
    func showCartScene() {
        guard let navigationController = navigationController else { return }
        let cart = Cart(userId: 1, id: 1, totalPrice: 0, restaurant: Restaurant(id: 1, name: "Restaurant", address_simplify: "", image: "", rating: 0, latitude: 0, longitude: 0, subcategories: []))
        let vc = factory.makeCartScene(coordinator: self, cart: cart)
        navigationController.pushViewController(vc, animated: true)
    }
}

