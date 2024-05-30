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
    let icon: String
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


struct RestaurantResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Restaurant]
}

struct Restaurant: Decodable {
    let id: Int
    let name: String
    let address_simplify: String
    let image: String
    let rating: Float
    let latitude: Float
    let longitude: Float
    let subcategories: [Int]
    
    var address: String {
        return address_simplify
    }
}

struct MenuItemResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [MenuItem]
}

struct MenuItem: Decodable {
    let id: Int
    let restaurant: Int
    let subcategory: Int
    let name: String
    let image: String
    let price: Float
    let likes: Int
    let dislikes: Int
}
