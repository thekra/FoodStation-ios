//
//  ResturantsTableViewCell.swift
//  HungerStationClone
//
//  Created by Gaida  on 09/11/2020.
//

import UIKit

class ResturantsTableViewCell: UITableViewCell {

    @IBOutlet var resStatusLabel: UILabel!
    @IBOutlet var resImage: UIImageView!
    @IBOutlet var resName: UILabel!
    @IBOutlet var resCategory: UILabel!
    @IBOutlet var resDistance: UILabel!
    @IBOutlet var resDeliveryTime: UILabel!
    @IBOutlet var resDeliveryCharge: UILabel!
    @IBOutlet var resRate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        resStatusLabel.roundCorners(corners: .allCorners, raduis: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
