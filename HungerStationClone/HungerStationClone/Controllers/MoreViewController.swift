//
//  MoreViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 08/11/2020.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForLoggedin()
    }
    
    func checkForLoggedin() {
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true {
            loginButton.isHidden = true
            profileButton.isHidden = false
        } else {
            loginButton.isHidden = false
            profileButton.isHidden = true
        }
    }
}
