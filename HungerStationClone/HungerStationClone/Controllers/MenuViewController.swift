//
//  MenuViewController.swift
//  HungerStationClone
//
//  Created by amthal enazi on 24/03/1442 AH.
//

import UIKit

class MenuViewController: UIViewController, AddToCartDelegate {
    
    func addToCartFinal(product: Products) {
        cart.append(product)
    }
    
    let ProductsViewControllerVC = ProductsViewController()
    var selectedProduct: Products!
    var product: Products!
    var productsPrice: Double = 0.0
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    // Add cart
    
    @IBOutlet var addCartView: UIView!
    @IBOutlet var totalPriceLabel: UILabel!
    
    
    struct Menue {
        var productName: String
        var price: Double
    }

    var menueProduct : [Products] = []
    var cart = [Products]()
    
    
    var prodArray = ["Value Meals", "Sandwiches", "Kiddie Meals", "Side Orders", "Desserts", "Special Offer"]
    var isFiltered = false
    var selectedCategory: String!
    
    
    override func viewWillAppear(_ animated: Bool) {
        if product != nil {
            
//            cart.append(product)
            let  currentTotalPrice =  cart.map{ $0.price }.reduce(0.0, +)
//            for p in cart {
//            productsPrice += p.price
//            }
            addCartView.isHidden = false
            totalPriceLabel.text = String(currentTotalPrice)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cart)
        print("count \(cart.count)")
        
//        ProductsViewControllerVC.delegate = self
 
        tableview.delegate = self
        tableview.dataSource = self
        CollectionView.delegate = self
        CollectionView.dataSource = self
        addCartView.isHidden = true 
        menuView.layer.cornerRadius = 20
        testDate()
    }
    
    func testDate() {
        
        let p1 = Products(id: "1", name: "mac chicken", price: 8.5, description: "chicken and mayo", category: "meal")
        let p2 =     Products(id: "3", name: "nuggets 9 pieces", price: 12.5, description: "chicken and mayo", category: "chicken")
        let p3 = Products(id: "2", name: "seazur salad", price: 23.5, description: "sauce", category: "salad")
        
        menueProduct.append(p1)
        menueProduct.append(p2)
        menueProduct.append(p3)

        addCartView.allRoundedConrners()
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: tableView
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedProduct = menueProduct[indexPath.row]
//        performSegue(withIdentifier: "product", sender: nil)
        let prodVC = self.storyboard?.instantiateViewController(withIdentifier: "prodVC") as! ProductsViewController
        prodVC.modalPresentationStyle = .fullScreen
        prodVC.product = selectedProduct
        prodVC.delegate = self
        self.present(prodVC, animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menueProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductsTableViewCell
        
        let product = menueProduct[indexPath.row]
        cell.mealName.text = product.name
        cell.priceLabel.text = String(product.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


// MARK: CollectionView
extension MenuViewController: UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prodArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prodCell", for: indexPath) as! MenuCategoriesCollectionViewCell
        
        
        if isFiltered {
            cell.cancelProductsFilter.isHidden = false
            if prodArray[indexPath.row] != selectedCategory {
                cell.contentView.isHidden = true
            
            } else {
                cell.contentView.isHidden = false
            }
        }
        cell.productCatogriesLabel.text = prodArray[indexPath.row]
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "product" {
//            let prodVC = segue.destination as! ProductsViewController
//            prodVC.modalPresentationStyle = .fullScreen
//            prodVC.product = selectedProduct
//        }
//    }
}
