//
//  Restaurant.swift
//  HungerStationClone
//
//  Created by Gaida  on 09/11/2020.
//

import Foundation
import UIKit


//class Cart {
//    var cart = [ProductList]()
//
//    func addProductInCart(product: ProductList){
//        cart.append(product)
//    }
//}
//struct Users {
//    
//    var id:String
//    var name :String
//    var phone: String
//    var orders: String
//   // var address: Address
//   // var Role
//}
//struct Restaurant {
//    
//    var id : String
//    //var owner: String
//    var product: Products
//    var category: String
//    var address: Address
//    var deliveryCharge: String
//    var status: String
//    var rating: String
//    var image: UIImage? = nil
//   // var minimumCharge: String
//    var name: String
//    
//    init(id:String,name:String, product: Products, category: String,address:Address,deliveryCharge:String,status:String,rating:String, image:UIImage) {
//        self.id = id
//        self.name = name
//        self.product = product
//        self.category = category
//        self.address = address
//        self.deliveryCharge = deliveryCharge
//        self.status = status
//        self.rating = rating
//        self.image = image
//    }
//    
//    init(name:String, product: Products, category: String,rating:String, image: UIImage?){
//        
//        self.init(id: "0", name: name, product: product, category: category, address: Address(id: "address1", lat: 123.23, long: 232.323, name: "ee"), deliveryCharge: "10", status: "open", rating: rating, image: image!)
//
//       
//    }
//    
//}
//struct Address {
//
//    var id: String
//    var lat: Double
//    var long :Double
//    var name : String
//}

//struct Products {
//    var id: String
//    var name: String
//    var price: Double
//    var description: String
//    var category: String
//    
//    init(id:String, name:String,price:Double,description:String,category:String) {
//        self.name = name
//        self.id = id
//        self.category = category
//        self.price = price
//        self.description = description
//        
//    }
//    
//}
//
//struct Orders {
//    var id : String
//    var uuid : String
//    var resturant: String
//    var status: String
//    var product: [Products]
//    
//    init(id:String, uuid:String ,resturant:String,status:String, product: [Products]) {
//        self.id = id
//        self.uuid = uuid
//        self.resturant = resturant
//        self.status = status
//        self.product = product
//    }
//    
//    ///second init
//    init(resturant:String ,product: [Products]) {
//        let serialNumber =  UUID().uuidString
//        self.init(id: "1", uuid: serialNumber, resturant: resturant,status : "pendding", product: product)
//    }
//    
//}
