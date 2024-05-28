//
//  SignInModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 28.05.2024.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let access: String
    let refresh: String
}
