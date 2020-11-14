//
//  OrderAPI.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 25/03/1442 AH.
//

import Foundation

class OrderAPI {
                        
    class func newOrder(restaurantID: String, productsID: [String], completion: @escaping (_ succuss: Bool) -> Void) {
        let token: String = UserDefaults.standard.string(forKey: "token")!
                                                  
        let url = URL(string: URLs.main + "order/" + "\(restaurantID)" + "/new")
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json",
            "Authorization": "\(token)"
        ]
        let body         = ["products" :  productsID]
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
                completion(true)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    class func listOrders(completion: @escaping (_ succuss: Bool) -> Void) {
        let token: String = UserDefaults.standard.string(forKey: "token")!
                                                  
        let url = URL(string: URLs.listOrders)
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json",
            "Authorization": "\(token)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
                completion(true)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
