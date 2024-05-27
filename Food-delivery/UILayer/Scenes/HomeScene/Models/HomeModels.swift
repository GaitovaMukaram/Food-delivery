//
//  DataForHome.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 25.05.2024.
//

import UIKit

struct Category {
    let id: Int
    let name: String
    let icon: UIImage?
}

struct Subcategory {
    let id: Int
    let name: String
    let image: UIImage?
    let category: Category
}

// Глобальная функция для получения категории по имени
func getCategoryByName(_ name: String, from categories: [Category]) -> Category {
    return categories.first { $0.name == name }!
}

// Глобальная функция для инициализации menuItems
func initializeSubcategories(categories: [Category]) -> [Subcategory] {
    return [
        Subcategory(id: 1, name: "Burgers", image: UIImage(named: "burgerImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 2, name: "Pizza", image: UIImage(named: "pizzaImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 3, name: "BBQ", image: UIImage(named: "bbqImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 4, name: "Fruit", image: UIImage(named: "fruitImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 5, name: "Sushi", image: UIImage(named: "sushiImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 6, name: "Noodle", image: UIImage(named: "noodleImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 7, name: "Burgers", image: UIImage(named: "burgerImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 8, name: "Pizza", image: UIImage(named: "pizzaImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 9, name: "BBQ", image: UIImage(named: "bbqImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 10, name: "Fruit", image: UIImage(named: "fruitImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 11, name: "Sushi", image: UIImage(named: "sushiImage"), category: getCategoryByName("Food", from: categories)),
        Subcategory(id: 12, name: "Noodle", image: UIImage(named: "noodleImage"), category: getCategoryByName("Food", from: categories))
    ]
}

struct Restaurant {
    let id: Int
    let name: String
    let address: String
    let distance: Double
    let image: UIImage?
    let rating: Double
    let latitude: Double
    let longitude: Double
    let subcategory: [Subcategory]
}


struct MenuItem {
    let id: Int
    let restaurant: Restaurant
    let subcategory: [Subcategory]
    let name: String
    let image: UIImage?
    let price: Double
    let likeIcon: UIImage?
    let likes: Int
    let dislikeIcon: UIImage?
    let dislikes: Int
}

