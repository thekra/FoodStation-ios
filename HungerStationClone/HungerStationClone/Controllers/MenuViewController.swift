//
//  MenuViewController.swift
//  HungerStationClone
//
//  Created by amthal enazi on 24/03/1442 AH.
//

import UIKit


class MenuViewController: UIViewController, AddToCartDelegate {
    
    
    func addProductToCart(product: ProductList) {
        MenuViewController.cart.append(product)
        print("func addProductToCart", MenuViewController.cart)
    }
    
    var selectedRestuarant: RestaurantResponseElement?
    var restaurantDeleget : RestaurantsDelegate!
    
    let ProductsViewControllerVC = ProductsViewController()
    var selectedProduct: ProductList!

    var productsPrice: Double = 0.0
    var totalPrice: Double = 0.0

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

    var menueProduct = [ProductList]()
    static var cart = [ProductList]()
    
    static var productID = [String]()
    static var restaurantID = ""
    
    var prodArray = ["Value Meals", "Sandwiches", "Kiddie Meals", "Side Orders", "Desserts", "Special Offer"]
    var isFiltered = false
    var selectedCategory: String!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       // print(cartStore.cart)
        
        if selectedProduct != nil {
////            cart.append(product)
//            let  currentTotalPrice =  cart.map{ Double($0.price) }.reduce(0.0, +)
////            for p in cart {
////            productsPrice += p.price
////            }
//            cart = 
            addCartView.isHidden = false
            totalPriceLabel.text = String(totalPrice)//String(currentTotalPrice)
        }
        print(MenuViewController.cart)
        print("count \(MenuViewController.cart.count)")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n\n\n\n\n\ne--------\n\n\n")
        print(selectedRestuarant)
        print("\n\n\n\n\n\n\ne--------\n\n\n")

        print(MenuViewController.cart)
        print("count \(MenuViewController.cart.count)")
        
        tableview.delegate = self
        tableview.dataSource = self
        CollectionView.delegate = self
        CollectionView.dataSource = self
        addCartView.isHidden = true 
        menuView.layer.cornerRadius = 20
        loadMenue()
        setOrderFucntion()
    }
    
    private func loadMenue() {
        
        selectedRestuarant?.products.forEach { menueProduct.append($0) }
        
        if let id = selectedRestuarant?.id {
            MenuViewController.restaurantID = id
        }
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
     //   prodVC.cartStore = cartStore
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
}

extension MenuViewController: RestaurantsDelegate {
    func loadResturants(resaurants: RestaurantResponseElement) {
        selectedRestuarant = resaurants
    }
}
extension MenuViewController {
    

    
    @objc private func sendOrder(_ sender: UITapGestureRecognizer) {
        MenuViewController.cart.forEach{ MenuViewController.productID.append($0.id)}
        
        OrderAPI.newOrder(restaurantID: MenuViewController.restaurantID, productsID: MenuViewController.productID) { (success) in
            if success {
                print("HEYYY")
            }
        }
    }
    
    private func setOrderFucntion(){
        
        let tapAddGesture = UITapGestureRecognizer(target: self, action: #selector(sendOrder(_:)))
        addCartView.isUserInteractionEnabled = true
        addCartView.addGestureRecognizer(tapAddGesture)
        
    }
}
