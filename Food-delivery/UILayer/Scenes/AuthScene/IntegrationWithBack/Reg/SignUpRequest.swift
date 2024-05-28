//
//  SignUpRequest.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 28.05.2024.
//

import Foundation


func signUpUser(email: String, firstName: String, lastName: String, password: String, passwordConfirmation: String, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
    let url = URL(string: "https://delivery-app-5t5oa.ondigitalocean.app/api/mobile/v0.0.1/auth/sign-up/")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    let signUpRequest = SignUpRequest(email: email, firstName: firstName, lastName: lastName, password: password, passwordConfirmation: passwordConfirmation)
    
    do {
        let requestBody = try JSONEncoder().encode(signUpRequest)
        request.httpBody = requestBody
        print("Request Body: \(String(data: requestBody, encoding: .utf8)!)")
    } catch {
        print("Failed to encode request body: \(error.localizedDescription)")
        completion(.failure(error))
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error in URLSession: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP Response Code: \(httpResponse.statusCode)")
        }
        
        guard let data = data else {
            print("No data received")
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            return
        }
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
            print("Response JSON: \(jsonResponse)")
            
            let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
            completion(.success(signUpResponse))
        } catch {
            print("Error decoding response: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    task.resume()
}
