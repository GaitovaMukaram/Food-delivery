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

struct Subcategory {
    let name: String
    let image: UIImage?
}

struct Restaurant {
    let name: String
    let address: String
    let distance: Double
    let image: UIImage?
    let rating: Double
    let latitude: Double
    let longitude: Double
    let subcategory: [String]
    let menuItems: [MenuItem]
}


struct MenuItem {
    let name: String
    let image: UIImage?
    let price: Double
    let likeIcon: UIImage?
    let likes: Int
    let dislikeIcon: UIImage?
    let dislikes: Int
}
