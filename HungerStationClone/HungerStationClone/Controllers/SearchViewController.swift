//
//  SearchViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 09/11/2020.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var RestaurantsArray = RestaurantResponse()
    var filteredRestaurant = RestaurantResponse()
    
    var isFiltered = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredRestaurant = RestaurantsArray
        searchBar.delegate = self
    }


}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredRestaurant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! ResturantsTableViewCell
        

        
        let restuarant = filteredRestaurant[indexPath.row]
        cell.resName.text = restuarant.name
        cell.resCategory.text = restuarant.category
        cell.resDeliveryCharge.text = String(restuarant.deliveryCharge)
        cell.resRate.text = String(restuarant.rating)
        
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
//        if searchText.isEmpty {
//            filteredRestaurant = RestaurantsArray
//        } else {
//            filteredRestaurant = RestaurantsArray.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
//        }
        tableView.reloadData()
        
        
    }
}
