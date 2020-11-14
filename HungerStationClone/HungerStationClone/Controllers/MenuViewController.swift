//
//  MenuViewController.swift
//  HungerStationClone
//
//  Created by amthal enazi on 24/03/1442 AH.
//

import UIKit

class MenuViewController: UIViewController, AddToCartDelegate {
    
    @IBOutlet var cancelFilterButton: UIButton!
    
    func addToCartFinal(product: Products) {
        MenuViewController.cart.append(product)
    }
    
    let ProductsViewControllerVC = ProductsViewController()
    var selectedProduct: Products!
    var product: Products!
    var productsPrice: Double = 0.0
    
    
    
    var catArray = ["Value Meals", "Sandwiches", "Kiddie Meals", "Side Orders", "Desserts", "Special Offer"]

    var filteredCat : [String] = []
//    var RestaurantsArray: [Restaurant]!
//    var filteredRestaurantsArray: [Restaurant]!
    var isFiltered = false
    var selectedCategory : String!
    var selectedCateogryIndex : Int!
   
    
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
    static var cart = [Products]()
    
    
    var prodArray = ["Value Meals", "Sandwiches", "Kiddie Meals", "Side Orders", "Desserts", "Special Offer"]
   
    
    override func viewWillAppear(_ animated: Bool) {
        print("count \(MenuViewController.cart.count)")
        if product == nil {
            print("ohoho empty")
        } else {
            print("not empty")
        }
        if product != nil {
            
//            cart.append(product)
            let  currentTotalPrice =  MenuViewController.cart.map{ $0.price }.reduce(0.0, +)
//            for p in cart {
//            productsPrice += p.price
//            }
            addCartView.isHidden = false
            totalPriceLabel.text = String(currentTotalPrice)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(MenuViewController.cart)
        print("count \(MenuViewController.cart.count)")
        
//        ProductsViewControllerVC.delegate = self
 
        tableview.delegate = self
        tableview.dataSource = self
        CollectionView.delegate = self
        CollectionView.dataSource = self
        addCartView.isHidden = true 
        menuView.layer.cornerRadius = 20
        testDate()
    }
    
    @IBAction func cancelFilterButtonTapped(_ sender: Any) {
        cancelFilteration()

    }
    
    
    func testDate() {
        
        let p1 = Products(id: "1", name: "mac chicken", price: 8.5, description: "chicken and mayo", category: "meal")
        let p2 =     Products(id: "3", name: "nuggets 9 pieces", price: 12.5, description: "chicken and mayo", category: "chicken")
        let p3 = Products(id: "2", name: "seazur salad", price: 23.5, description: "sauce", category: "salad")
        
        menueProduct.append(p1)
        menueProduct.append(p2)
        menueProduct.append(p3)

        addCartView.allRoundedConrners()
        
        filteredCat = catArray
       // filteredRestaurantsArray = RestaurantsArray
        cancelFilterButton.roundCorners(corners: .allCorners, raduis: 40)
        cancelFilterButton.backgroundColor = .yellow
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
        
        selectedCategory = filteredCat[indexPath.row]
               
               if let index = filteredCat.firstIndex(of: selectedCategory) {
                   selectedCateogryIndex = index
                   FilterCatogries(selectedCat: selectedCategory, index: index)
               }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = UIScreen.main.bounds.size.width
        let height = 30.7
        return CGSize(width: Double(width), height: height)
        
        
        
       }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCollectionViewCell
                
                if isFiltered {
                    
                    cancelFilterButton.isHidden = false
                    cell.categoryLabel.backgroundColor = .yellow
        //            if catArray[indexPath.row] != selectedCategory {
        //                cell.contentView.isHidden = true
        //            } else {
        //
        //                cell.contentView.isHidden = false
        //            }
                } else {
                    cancelFilterButton.isHidden = true
        //            cell.contentView.isHidden = false
                    cell.categoryLabel.backgroundColor = .clear
                }
                
                cell.categoryLabel.text = filteredCat[indexPath.row]

                return cell
    }
    
    private func FilterCatogries(selectedCat: String, index: Int){
        
        
        isFiltered = true
        CollectionView.isScrollEnabled = false
        filteredCat.swapAt(index, 0)
//        filteredRestaurantsArray = RestaurantsArray.filter{ $0.category == selectedCat}
        
        CollectionView.setContentOffset(.zero, animated: false)
        filteredCat = filteredCat.filter{ $0 == selectedCat}
        CollectionView.reloadData()
       // tableview.reloadData()
        
    }
    
    private func cancelFilteration(){
//        filteredRestaurantsArray = RestaurantsArray
                filteredCat = catArray
        
                filteredCat.swapAt(selectedCateogryIndex, 0)
                isFiltered = false
        CollectionView.isScrollEnabled = true

        tableview.reloadData()
        CollectionView.reloadData()

    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "product" {
//            let prodVC = segue.destination as! ProductsViewController
//            prodVC.modalPresentationStyle = .fullScreen
//            prodVC.product = selectedProduct
//        }
//    }
}

