//
//  Restaurants.swift
//  HungerStationClone
//
//  Created by amthal enazi on 26/03/1442 AH.
//

import Foundation

// MARK: - RestaurantResponseElement
struct RestaurantResponseElement: Codable {
    let products: [ProductList]
    let category: String?
    let rating: Int
    let deliveryCharge, minimumCharge: Double
    let id: String
    let address: Address
    let name, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case products, category, rating, deliveryCharge, minimumCharge
        case id = "_id"
        case address, name, createdAt, updatedAt
    }
}

// MARK: - Address
struct Address: Codable {
    let streetName, name: String?
    let location: Coordinates
    let id, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case streetName, name, location
        case id = "_id"
        case createdAt, updatedAt
    }
}

// MARK: - Product
struct ProductList: Codable {
    
    let id, name: String
    let price: Int
    let category: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, price, category, createdAt, updatedAt
    }
}

typealias RestaurantResponse = [RestaurantResponseElement]

struct Products: Encodable {
    let id : [String]
}
