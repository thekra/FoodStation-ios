//
//  CategoriesCollectionViewCell.swift
//  HungerStationClone
//
//  Created by Gaida  on 09/11/2020.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var cancelFilter: UIButton!
    
    override func awakeFromNib() {
        setUI()
    }
  
    
    func setUI(){
        cancelFilter.isHidden = true
        categoryLabel.roundCorners(corners: .allCorners, raduis: 10)
        categoryLabel.backgroundColor = .yellow
    }
    
}
