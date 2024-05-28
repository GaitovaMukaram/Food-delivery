//
//  CartModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

struct Cart {
    let userId: Int
    let id: Int
    var totalPrice: Float
    let restaurant: Restaurant
}

struct CartMenuItem {
    let cart: Cart
    let menuItem: MenuItem
    var quantity: Int
    var totalPrice: Float
}
