//
//  LoginStructs.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 24/03/1442 AH.
//

import Foundation

struct Generate: Encodable {
    let phone: String
}

struct GenerateResponse: Decodable {
    let authenticationId: String
}

struct ValidateKey: Encodable {
    let key: String
}

struct ValidateResponse: Decodable {
    let __token: String
}
