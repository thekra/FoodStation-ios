//
//  OTPViewController.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 25/03/1442 AH.
//

import UIKit

class OTPViewController: UIViewController {
    
    var authID: String!
    @IBOutlet weak var OTPfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func validateKey(_ sender: UIButton) {
        guard let OTP = OTPfield.text else { return }
        print("OTP",  OTP)
        AuthAPI.validateKey(authId: authID, key: OTP) { (ValidateResponse, success) in
            if success {
                DispatchQueue.main.async {
                let token = ValidateResponse.__token
                print("token", ValidateResponse.__token)
                self.dismiss(animated: true, completion: nil)
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            }
        }
        }
    }
}
