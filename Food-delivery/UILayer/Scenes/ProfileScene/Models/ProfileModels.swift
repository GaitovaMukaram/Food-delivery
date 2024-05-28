//
//  ProfileModels.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 26.05.2024.
//

import UIKit

struct User {
    let name: String
    let email: String
    let avatarImage: UIImage?
}

struct ProfileOption {
    let title: String
    let action: () -> Void
}
