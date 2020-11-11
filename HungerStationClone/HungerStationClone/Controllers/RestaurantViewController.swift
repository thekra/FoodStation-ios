//
//  RestaurantViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 08/11/2020.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var cancelFilterButton: UIButton!
    
    
    var catArray = ["Arabic","Fast Food","American","Italian","Dessert","Indian"]
    var filteredCat : [String] = []
    var RestaurantsArray: [Restaurant]!
    var filteredRestaurantsArray: [Restaurant]!
    
    var isFiltered = false
    var selectedCategory : String!
    var selectedCateogryIndex : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        testData()
      
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        navigateToSearchVC()
        
    }
    
    
    @IBAction func cancelFilterTapped(_ sender: Any) {
        cancelFilteration()
    }
    
    
    private func testData(){
        // MARK:- Test Data
        
        let macProduct = Products(id: "1", name: "mac chicken", price: 23.5, description: "chicken and mayo", category: "meal")
        
        let Macdonalds = Restaurant(name: "Mac",
                                    product: macProduct,
                                    category: "Fast Food",
                                    rating: "3.5", image: UIImage(named: "macLogo"))
        
        let sharProduct1 = Products(id: "1", name: "shawrma", price: 22.5, description: "chicken wrap", category: "meal")
        
        let Shawrmer = Restaurant(name: "Shawrmer", product:sharProduct1 , category: "Arabic",  rating: "4.5", image:  UIImage(named: "shawrmerlogo"))
        
        RestaurantsArray  = [Macdonalds,Shawrmer]
        filteredRestaurantsArray = RestaurantsArray
        filteredCat = catArray
        
        cancelFilterButton.roundCorners(corners: .allCorners, raduis: 40)
        cancelFilterButton.backgroundColor = .yellow
    }
}


extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! ResturantsTableViewCell
        
        let restuarant = filteredRestaurantsArray[indexPath.row]
        cell.resImage.image = restuarant.image
        cell.resName.text = restuarant.name
        cell.resCategory.text = restuarant.category
        cell.resDeliveryCharge.text = restuarant.deliveryCharge
        cell.resRate.text = restuarant.rating
        cell.resStatusLabel.text = restuarant.status
        
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCat.count
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = UIScreen.main.bounds.size.width
        let height = 30.7
        return CGSize(width: Double(width), height: height)
        
        
        
       }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt\(indexPath)")
        
        selectedCategory = filteredCat[indexPath.row]
        
        if let index = filteredCat.firstIndex(of: selectedCategory) {
            selectedCateogryIndex = index
            FilterCatogries(selectedCat: selectedCategory, index: index)
        }
    }
    

    private func FilterCatogries(selectedCat: String, index: Int){
        
        isFiltered = true
        collectionView.isScrollEnabled = false
        filteredCat.swapAt(index, 0)
        filteredRestaurantsArray = RestaurantsArray.filter{ $0.category == selectedCat}
        
        collectionView.setContentOffset(.zero, animated: false)
        filteredCat = filteredCat.filter{ $0 == selectedCat}
        collectionView.reloadData()
        tableView.reloadData()
        
    }
    
    
}

extension RestaurantViewController {
    private func navigateToSearchVC(){
        performSegue(withIdentifier: "searchVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "searchVC":
            let searchVC = segue.destination as! SearchViewController
            searchVC.RestaurantsArray = RestaurantsArray
        default:
            print("mom")
        }
    }
    
    private func cancelFilteration(){
        filteredRestaurantsArray = RestaurantsArray
        filteredCat = catArray
        filteredCat.swapAt(selectedCateogryIndex, 0)
        isFiltered = false
        collectionView.isScrollEnabled = true

        tableView.reloadData()
        collectionView.reloadData()

    }
    
    
}

