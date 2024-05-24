//
//  UserStorage.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 24.05.2024.
//

import Foundation


class UserStorage {
    static let shared = UserStorage()
    
    var passedOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "passedOnboarding") }
        set { UserDefaults.standard.set(newValue, forKey: "passedOnboarding") }
    }
}
