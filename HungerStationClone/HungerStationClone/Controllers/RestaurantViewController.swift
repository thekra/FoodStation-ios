//
//  RestaurantViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 08/11/2020.
//

import UIKit

class RestaurantViewController: UIViewController {

    var delegate : RestaurantsDelegate!
    
    var selectedRestuarant: RestaurantResponseElement!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var cancelFilterButton: UIButton!
    
    
    var catArray = ["Arabic","Fast Food","American","Italian","Dessert","others"]
    var filteredCategoryArray = [String]()


    var RestaurantsArray = RestaurantResponse()
    var filteredRestaurantsArray = RestaurantResponse()
    
    var isFiltered = false
    var selectedCategory : String!
    var selectedCateogryIndex : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCategoryArray = catArray
        cancelFilterButton.roundCorners(corners: .allCorners, raduis: 40)
        cancelFilterButton.backgroundColor = .yellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRestaurantList()
        
        filteredRestaurantsArray = RestaurantsArray
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        navigateToSearchVC()
    }
    
    
    @IBAction func cancelFilterTapped(_ sender: Any) {
        cancelFilteration()
    }
    
    func loadRestaurantList(){
        RestaurantAPI.listResturants { [self] (response, success) in
            if success {
                self.RestaurantsArray = response
                filteredRestaurantsArray = RestaurantsArray
                print("\n\n\n\n\n\n\n\n")
              //  print(response)
                for r in response {
                    print(r)
                }
                print("\n\n\n\n\n\n\n\n")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("eRRRRORMEEH")
            }
        }

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
        cell.resName.text = restuarant.name
        cell.resCategory.text = restuarant.category
        cell.resDeliveryCharge.text = String(restuarant.deliveryCharge)
        cell.resRate.text = String(restuarant.rating)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRestuarant = filteredRestaurantsArray[indexPath.row]
        
        
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
       // menuVC.selectedRestuarant = selectedRestuarant
        delegate = menuVC
        delegate.loadResturants(resaurants: selectedRestuarant)
        menuVC.modalPresentationStyle = .fullScreen
        present(menuVC, animated: true, completion: nil)

    }
}

extension RestaurantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        
        
        
        
        if isFiltered {
            
            cancelFilterButton.isHidden = false
            cell.categoryLabel.backgroundColor = .yellow
            
        } else {
            cancelFilterButton.isHidden = true
            cell.categoryLabel.backgroundColor = .clear
        }
        cell.categoryLabel.text = catArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = UIScreen.main.bounds.size.width
        let height = 30.7
        return CGSize(width: Double(width), height: height)
        
        
        
       }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt\(indexPath)")
        
        selectedCategory = filteredCategoryArray[indexPath.row]
        if let index = filteredCategoryArray.firstIndex(of: selectedCategory) {
            selectedCateogryIndex = index
            FilterCatogries(selectedCat: selectedCategory, index: index)
        }
    }
    

    private func FilterCatogries(selectedCat: String, index: Int){
        
        isFiltered = true
        collectionView.isScrollEnabled = false
        catArray.swapAt(index, 0)
        collectionView.setContentOffset(.zero, animated: false)

        filteredRestaurantsArray = RestaurantsArray.filter{ $0.category == selectedCat}
        
        filteredCategoryArray = catArray.filter {
            $0 == selectedCategory
        }
        
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
        filteredCategoryArray = catArray
        catArray.swapAt(selectedCateogryIndex, 0)
        
        isFiltered = false
        collectionView.isScrollEnabled = true

        tableView.reloadData()
        collectionView.reloadData()

    }
    
    
}

