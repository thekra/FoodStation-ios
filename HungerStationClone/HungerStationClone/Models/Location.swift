//
//  Location.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 25/03/1442 AH.
//

import Foundation

struct Location: Encodable {
    let name: String?
    let coordinates: [Coordinates]
    let streetName: String
}

struct Coordinates: Encodable {
    let latitude: Double
    let longitude: Double
}


// MARK: - User
struct User: Codable {
//    let orders: [Any]
    let status, id, role, phone: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case role, phone, createdAt, updatedAt
    }
}

struct Product: Encodable {
    let name: String
}
