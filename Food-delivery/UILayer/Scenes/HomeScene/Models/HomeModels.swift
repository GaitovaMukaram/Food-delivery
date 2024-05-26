//
//  DataForHome.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit

struct Category {
    let name: String
    let icon: UIImage?
}

struct Restaurant {
    let name: String
    let address: String
    let distance: Double
    let image: UIImage?
    let rating: Double
    let latitude: Double
    let longitude: Double
    let menuItems: [String]
}



struct MenuItem {
    let name: String
    let image: UIImage?
}
