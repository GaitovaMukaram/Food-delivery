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
    
    if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    } else {
        print("No access token found")
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        // Логирование сырых данных
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received raw data: \(jsonString)")
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            // Логирование декодированных данных
            print("Decoded data: \(decodedData)")
            completion(.success(decodedData))
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    task.resume()
}


func sendData<T: Decodable, U: Encodable>(to urlString: String, method: String = "POST", data: U, completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    } else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No access token found"])))
        return
    }
    
    do {
        let jsonData = try JSONEncoder().encode(data)
        request.httpBody = jsonData
        
        print("Request data: \(String(data: jsonData, encoding: .utf8) ?? "No data")")
        print("Request headers: \(request.allHTTPHeaderFields ?? [:])")
    } catch {
        completion(.failure(error))
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
        
        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
            print("Decoding error: \(error.localizedDescription)")
        }
    }
    
    task.resume()
}
