//
//  RestaurantsRequest.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 28.05.2024.
//

import Foundation

func fetchRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
    let url = URL(string: "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/restaurants/")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // Получение токена из UserDefaults
    if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    } else {
        print("No access token found")
        completion(.failure(NSError(domain: "No access token", code: -1, userInfo: nil)))
        return
    }
    

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
            completion(.failure(error))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let restaurantResponse = try decoder.decode(RestaurantResponse.self, from: data)
            completion(.success(restaurantResponse.results))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

