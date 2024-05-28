//
//  CategoriesRequest.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 28.05.2024.
//

import Foundation

func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
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
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}
