//
//  OrdersTableViewCell.swift
//  HungerStationClone
//
//  Created by Gaida  on 09/11/2020.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImage: UIImageView!
    
    @IBOutlet var restaurantName: UILabel!
    
    @IBOutlet var orderStatus: UILabel!
    
    @IBOutlet var orderDate: UILabel!
    
    @IBOutlet var orderTotalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        restaurantImage.layer.borderWidth = 0.5
        restaurantImage.allRoundedConrners()
        restaurantImage.layer.borderColor = UIColor.red.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
