//
//  OrdersViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 08/11/2020.
//

import UIKit

class OrdersViewController: UIViewController {

    
    @IBOutlet var ordersTableView: UITableView!
    //private var userOrders: [Orders] = []
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = " d MMM y"
        return formatter
    }()
  
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        testData()
    }
    
    
    
    private func testData(){
//        let macProduct = Products(id: "1", name: "mac chicken", price: 23.5, description: "chicken and mayo", category: "meal")
//        let macProduct2 = Products(id: "1", name: "chicken nuggets", price: 19.5, description: "chicken and mayo", category: "meal")
//        let order1 = Orders(resturant: "Mac", product: [macProduct,macProduct2])
//        userOrders.append(order1)
//
//        let prod1 = Products(id: "1", name: "shawrma", price: 13.5, description: "chicken and mayo", category: "meal")
//        let prod2 = Products(id: "1", name: "rice", price: 10.5, description: "chicken and mayo", category: "meal")
//        let prod3 = Products(id: "1", name: "chicken", price: 5.5, description: "chicken and mayo", category: "meal")
//
//        let order2 = Orders(resturant: "Shawrmer", product: [prod1,prod2,prod3])
//        userOrders.append(order2)
    }
    
    

}
extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        if userOrders.count == 0 {
//            
//            tableView.setEmptyMessage("you don't have any orders yet.")
//            
//        } else {
//            tableView.restore()
//        }
//        
//        return userOrders.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
//
//        let order = userOrders[indexPath.row]
//        cell.restaurantName.text = order.resturant
//        cell.orderStatus.text = order.status
//        cell.orderDate.text =  formatter.string(from: Date())
//        cell.orderTotalPrice.text = calcTotalPrice(products: order.product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   //     let selectedOrder = userOrders[indexPath.row]
        #warning("transfer to order detail vc")
    }
    
    
}

extension OrdersViewController {
    
//    private func calcTotalPrice(products: [Products]) -> String{
//
//    //    let totalPrice =  products.map {   $0.price  }.reduce(0, +)
//
//        return String(totalPrice)
//    }
    func listOrders() {
        OrderAPI.listOrders { (success) in
            if success {
                print("jf")
            }
        }
    }
}
