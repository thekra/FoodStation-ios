//
//  locationAPI.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 25/03/1442 AH.
//

import Foundation

class locationAPI {
    
    class func saveLocation(name: String, coordinates: [Coordinates], streetName: String, completion: @escaping (User, _ succuss: Bool) -> Void) {
        let token: String = UserDefaults.standard.string(forKey: "token")!
        let url = URL(string: URLs.saveLocation)
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PATCH"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json",
            "Authorization": "\(token)"
        ]
        let body         = ["address" : Location(name: name, coordinates: coordinates, streetName: streetName)]
        
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
                let responseObject = try JSONDecoder().decode(User.self, from: data)
                if response.statusCode == 200 {
                    completion(responseObject, true)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}


