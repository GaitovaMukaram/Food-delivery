//
//  PaymentModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit


struct CardDataResponse: Codable {
    let id: Int
    let card_number: String
}

struct CardData: Codable {
    let card_number: String
    let expiration_year: Int
    let expiration_month: Int
    let cvv: String
}

enum PaymentMethodTypeEnum {
    case creditCard
    
    var icon: UIImage? {
        switch self {
        case .creditCard:
            return UIImage(systemName: "creditcard")
        }
    }
    
    var description: String {
        switch self {
        case .creditCard:
            return "Credit Card"
        }
    }
}

struct PaymentMethodType {
    let type: PaymentMethodTypeEnum
}


struct PaymentMethod: Decodable {
    let id: Int
    let card_number: String
}


struct PaymentMethodResponse: Decodable {
    let count: Int
    let results: [PaymentMethod]
}
