//
//  SignUpModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 28.05.2024.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let passwordConfirmation: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case password
        case passwordConfirmation = "password_confirmation"
    }
}

struct SignUpResponse: Decodable {
    let email: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}



