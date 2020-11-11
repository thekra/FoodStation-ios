//
//  URLs.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 24/03/1442 AH.
//

import Foundation

struct URLs {
    
    static let main        = "http://10.20.35.53:5000/api/v1/"
    
    static let generate    = main + "authentication/user/generate/key"
    
    static let approveOTP  = main + "authentication/user/validate/key"
    
    static let verfiyToken = main + "authentication/user/validate/access-token"
    
//    enum endpoints: String {
//        case generateKey = "authentication/user/generate/key"
//        case approveOTP = "authentication/user/validate/key/"////auth id from generate
//        case verfiyToken = "authentication/user/validate/access-token"
//    }
}
