//
//  DataForHome.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit

struct Category: Decodable {
    let id: Int
    let name: String
    let icon: String?
}

struct CategoryResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Category]
}

struct Subcategory: Decodable {
    let id: Int
    let name: String
    let image: String
    let category: Int
}

struct SubcategoryResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Subcategory]
}


struct Restaurant {
    let id: Int
    let name: String
    let address: String
    let distance: Float
    let image: UIImage?
    let rating: Float
    let latitude: Float
    let longitude: Float
    let subcategory: [Subcategory]
}

struct MenuItem {
    let id: Int
    let restaurant: Restaurant
    let subcategory: [Subcategory]
    let name: String
    let image: UIImage?
    let price: Float
    let likeIcon: UIImage?
    let likes: Int
    let dislikeIcon: UIImage?
    let dislikes: Int
}
