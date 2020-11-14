//
//  AuthAPI.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 24/03/1442 AH.
// last push

import Foundation

class AuthAPI {
    
    class func generateKey(phone: String, completion: @escaping (GenerateResponse, _ succuss: Bool) -> Void) {
        let url = URL(string: URLs.generate)
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json"
        ]
        let body         = Generate(phone: phone)
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
                let responseObject = try JSONDecoder().decode(GenerateResponse.self, from: data)
                completion(responseObject, true)
                
            } catch {
                print(error)
                if response.statusCode == 401 {
                    print("incorrect email/password")
                } else if response.statusCode == 422 {
                    print("Missing/invalid input")
                } else if response.statusCode == 500 {
                    print("Server Error")
                }
            }
        }
        task.resume()
    }
    
    class func validateKey(authId: String, key: String, completion: @escaping (ValidateResponse, _ succuss: Bool) -> Void) {
        
        let url = URL(string: URLs.approveOTP + "\(authId)")
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json"
        ]
        let body         = ValidateKey(key: key)
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
                let responseObject = try JSONDecoder().decode(ValidateResponse.self, from: data)
                completion(responseObject, true)
                
            } catch {
                
                print(error)
                if response.statusCode == 401 {
                    print("incorrect email/password")
                } else if response.statusCode == 422 {
                    print("Missing/invalid input")
                } else if response.statusCode == 500 {
                    print("Server Error")
                }
            }
        }
        task.resume()
    }
}
