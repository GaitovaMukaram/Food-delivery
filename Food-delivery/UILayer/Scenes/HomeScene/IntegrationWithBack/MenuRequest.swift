//
//  MenuRequest.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 28.05.2024.
//

import Foundation

func fetchMenuItems(completion: @escaping (Result<[MenuItem], Error>) -> Void) {
    guard let url = URL(string: "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/menu/") else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "accept")
    
    // Получение токена из UserDefaults
    if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    } else {
        print("No access token found")
        completion(.failure(NSError(domain: "No access token", code: -1, userInfo: nil)))
        return
    }
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        do {
            let response = try JSONDecoder().decode(MenuItemResponse.self, from: data)
            completion(.success(response.results))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}

