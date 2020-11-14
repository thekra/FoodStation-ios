//
//  Extension+Layout.swift
//  ToDoList
//
//  Created by Gaida  on 02/11/2020.
//

import Foundation
import UIKit

extension UIView {

    
    /// Function to set either height, width or both.
    func setDimensions(height: CGFloat? = nil , width: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    /// Function to make specefic corners round.
    func roundCorners(corners: UIRectCorner, raduis: Int = 8){
        let maskPath1 = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: raduis, height: raduis))
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    /// Function to make the corner of UIView rounded.
    func allRoundedConrners(radius: CGFloat = 10){
        self.layer.cornerRadius = radius
    }
    
   
 
}

extension UIColor {
    
    static let yellow = #colorLiteral(red: 0.9725490196, green: 0.8274509804, blue: 0.03137254902, alpha: 1)
    static let lightPink =  #colorLiteral(red: 1, green: 0.9294117647, blue: 0.9490196078, alpha: 1)  //UIColor(red: 0.9725, green: 0.9216, blue: 0.8902, alpha: 1.0)
    static let peachyPink = #colorLiteral(red: 0.937254902, green: 0.631372549, blue: 0.5529411765, alpha: 1)  //UIColor(red: 0.9373, green: 0.6314, blue: 0.5529, alpha: 1.0) /* #efa18d */
    static let offWhite =   #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9607843137, alpha: 1)  //UIColor(red: 0.9686, green: 0.9647, blue: 0.9608, alpha: 1.0) /* #f7f6f5 */
    static let lightPeach = #colorLiteral(red: 0.9725490196, green: 0.9215686275, blue: 0.8901960784, alpha: 1)
    static let errorRed =   #colorLiteral(red: 0.8274509804, green: 0.4745098039, blue: 0.431372549, alpha: 1)
    static let darkGreen =  #colorLiteral(red: 0.5176470588, green: 0.6078431373, blue: 0.5490196078, alpha: 1)
    static let darkPeach = #colorLiteral(red: 0.8862745098, green: 0.5607843137, blue: 0.4352941176, alpha: 1)

}

extension UIViewController {
    func transferTo(viewController: UIViewController, storyboardName:String = "Main", id:String, push: UINavigationController){
        let storyBoard = UIStoryboard(name: storyboardName, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: id)
        push.pushViewController(viewController, animated:true)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "[^05](5|0|3|6|4|9|1|8|7)([0-9]{7})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
}
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
