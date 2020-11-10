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
    
    var RestaurantsArray: [Restaurant]!
    var filteredRestaurant: [Restaurant]!
    var isFiltered = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return isFiltered ? filteredRestaurant.count : RestaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! ResturantsTableViewCell
        
        let restuarantList = isFiltered ? filteredRestaurant : RestaurantsArray

        let restuarant = restuarantList![indexPath.row]
        cell.resImage.image = restuarant.image
        cell.resName.text = restuarant.name
        cell.resCategory.text = restuarant.category
        cell.resDeliveryCharge.text = restuarant.deliveryCharge
        cell.resRate.text = restuarant.rating
        cell.resStatusLabel.text = restuarant.status
        
        
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
        if searchText.isEmpty {
            filteredRestaurant = RestaurantsArray
        } else {
            filteredRestaurant = RestaurantsArray.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
        }
        isFiltered = true
        tableView.reloadData()
        
    }
}