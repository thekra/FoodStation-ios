//
//  Location.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 25/03/1442 AH.
//

import Foundation

struct Location: Codable {
    let name: String?
    let coordinates: [Coordinates]
    let streetName: String
}

struct Coordinates: Codable {
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

struct Product: Codable {
    let name: String
}
