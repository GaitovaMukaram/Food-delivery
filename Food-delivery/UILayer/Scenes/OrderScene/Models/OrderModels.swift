//
//  OrderModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 27.05.2024.
//

struct Order {
    let userId: Int
    let id: Int
    var totalPrice: Float
    let restaurant: Restaurant
}

struct OrderMenuItem {
    let order: Order
    let menuItem: MenuItem
    var quantity: Int
    var totalPrice: Float
}
