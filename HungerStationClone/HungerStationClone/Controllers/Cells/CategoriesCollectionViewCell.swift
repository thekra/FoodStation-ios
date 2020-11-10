//
//  CategoriesCollectionViewCell.swift
//  HungerStationClone
//
//  Created by Gaida  on 09/11/2020.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
       
    override func awakeFromNib() {
        setUI()
    }
  
    
    func setUI(){
        categoryLabel.roundCorners(corners: .allCorners, raduis: 5)
        categoryLabel.backgroundColor = .clear
    }
    
}
