//
//  AuthViewController.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 24/03/1442 AH.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    var authID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func generateKey(_ sender: UIButton) {
        guard let phoneNum = phoneNumber.text else { return }
        
        AuthAPI.generateKey(phone: phoneNum) { (GenerateResponse, success) in
            if success {
                self.authID = GenerateResponse.authenticationId
                self.performSegue(withIdentifier: "OTP", sender: nil)
                print("authID", self.authID)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("authIDsegue", self.authID)
        if segue.identifier == "OTP" {
            let vc = segue.destination as! OTPViewController
            vc.authID = authID
        }
    }
}
