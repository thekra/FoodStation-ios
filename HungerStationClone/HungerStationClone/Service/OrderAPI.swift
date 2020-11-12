//
//  OrderAPI.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 25/03/1442 AH.
//

import Foundation

class OrderAPI {
                        // + res ID
    class func newOrder(name: String, completion: @escaping (_ succuss: Bool) -> Void) {
        let token: String = UserDefaults.standard.string(forKey: "token")!
                                                    // resID
        let url = URL(string: URLs.main + "order/" + "5fabccc7ff872a167f30d569" + "/new")
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "app": "client",
            "platform": "ios",
            "Content-Type": "application/json",
            "Authorization": "\(token)"
        ]
        let body         = ["products" : Product(name: name)]
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error \(error)")
                return
            }
//            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
                //let responseObject = try JSONDecoder().decode(User.self, from: data)
                completion(true)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
