//
//  restaurantAPI.swift
//  HungerStationClone
//
//  Created by amthal enazi on 26/03/1442 AH.
//

import Foundation

class RestaurantAPI {
                        
    class func listResturants(completion: @escaping (RestaurantResponse, _ succuss: Bool) -> Void) {
        let url = URL(string: URLs.listResturant)
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json"
        ]
        
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringCacheData
        
        let task = URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            
            guard let data = data else { return }
            print("data")
            do {
                
                let responseObject = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                    completion(responseObject, true)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
