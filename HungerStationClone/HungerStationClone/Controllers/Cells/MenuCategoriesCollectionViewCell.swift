//
//  MenuCategoriesCollectionViewCell.swift
//  HungerStationClone
//
//  Created by amthal enazi on 24/03/1442 AH.
//

import UIKit

class MenuCategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productCatogriesLabel: UILabel!
    @IBOutlet weak var cancelProductsFilter: UIButton!
    
    override func awakeFromNib() {
        setUI()
    }
  
    
    func setUI(){
        cancelProductsFilter.isHidden = true
        productCatogriesLabel.roundCorners(corners: .allCorners, raduis: 10)
        productCatogriesLabel.backgroundColor = .yellow
    }
}
