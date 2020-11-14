//
//  URLs.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 24/03/1442 AH.
//

import Foundation

struct URLs {
    
    static let main        = "http://10.20.35.53:5000/api/v1/"
    
    // MARK:- Auth
    static let generate    = main + "authentication/user/generate/key"
    static let approveOTP  = main + "authentication/user/validate/key/"
    static let verfiyToken = main + "authentication/user/validate/access-token"
    
    // MARK:- Restaurants
    static let listResturant = main + "resturant/get/all"
    
    // MARK:- User
    static let saveLocation = main + "user/update"
    
    // MARK:- Orders
    static let listOrders   = main + "/order/get/all"
    
}
