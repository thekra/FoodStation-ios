//
//  protocols.swift
//  HungerStationClone
//
//  Created by amthal enazi on 26/03/1442 AH.
//

import Foundation


protocol AddToCartDelegate {
    func addProductToCart(product: ProductList)
}

protocol RestaurantsDelegate {
    func loadResturants(resaurants: RestaurantResponseElement)
}
