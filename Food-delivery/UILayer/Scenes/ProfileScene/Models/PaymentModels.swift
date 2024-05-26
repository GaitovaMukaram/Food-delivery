//
//  PaymentModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

enum PaymentMethodType {
    case creditCard
    case addNew
    
    var icon: UIImage? {
        switch self {
        case .creditCard:
            return UIImage(systemName: "creditcard") // Укажите правильное изображение
        case .addNew:
            return UIImage(systemName: "plus.circle") // Укажите правильное изображение
        }
    }
    
    var description: String {
        switch self {
        case .creditCard:
            return "Credit Card"
        case .addNew:
            return "Add new payment method"
        }
    }
}


struct PaymentMethod {
    let type: PaymentMethodType
    let details: String
}

struct CardDetails {
    let cardImage: UIImage?
    let bankNameLabel: String
    let userName: String
    let cardNumber: Int
    let expiryDate: Date
    let cvv: Int
}
