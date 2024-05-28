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

struct Subcategory {
    let id: Int
    let name: String
    let image: UIImage?
    let category: Category
}

// Глобальная функция для получения категории по имени
func getCategoryByName(_ name: String, from categories: [Category]) -> Category? {
    return categories.first { $0.name == name }
}

// Глобальная функция для инициализации menuItems
func initializeSubcategories(categories: [Category]) -> [Subcategory] {
    guard let foodCategory = getCategoryByName("Food", from: categories) else { return [] }
    
    return [
        Subcategory(id: 1, name: "Burgers", image: UIImage(named: "burgerImage"), category: foodCategory),
        Subcategory(id: 2, name: "Pizza", image: UIImage(named: "pizzaImage"), category: foodCategory),
        Subcategory(id: 3, name: "BBQ", image: UIImage(named: "bbqImage"), category: foodCategory),
        Subcategory(id: 4, name: "Fruit", image: UIImage(named: "fruitImage"), category: foodCategory),
        Subcategory(id: 5, name: "Sushi", image: UIImage(named: "sushiImage"), category: foodCategory),
        Subcategory(id: 6, name: "Noodle", image: UIImage(named: "noodleImage"), category: foodCategory),
        Subcategory(id: 7, name: "Burgers", image: UIImage(named: "burgerImage"), category: foodCategory),
        Subcategory(id: 8, name: "Pizza", image: UIImage(named: "pizzaImage"), category: foodCategory),
        Subcategory(id: 9, name: "BBQ", image: UIImage(named: "bbqImage"), category: foodCategory),
        Subcategory(id: 10, name: "Fruit", image: UIImage(named: "fruitImage"), category: foodCategory),
        Subcategory(id: 11, name: "Sushi", image: UIImage(named: "sushiImage"), category: foodCategory),
        Subcategory(id: 12, name: "Noodle", image: UIImage(named: "noodleImage"), category: foodCategory)
    ]
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
