//
//  HomeViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 08/11/2020.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    
    @IBOutlet var resturantView: UIView!
    @IBOutlet var locationsLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var flag = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationsLabel.text = UserDefaults.standard.string(forKey: "addressLabel") ?? locationsLabel.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setUpUI()
        setupRestaurantTap()
        configureLocationLabel()
        
    }
    
    @IBAction func newOrder(_ sender: UIButton) {
        OrderAPI.newOrder(name: "5fabcdbbbac0b316c1f82410") { (success) in
            if success {
                print("New Order")
            }
        }
    }
}

// MARK: - Additional Functions
extension HomeViewController {
    
    private func setUpUI() {
        
        locationsLabel.text = "choose location"
        let resBackgroundImage = UIImage(named: "foodBG")
        let backgroundColor = UIColor(patternImage: resBackgroundImage!)
        resturantView.backgroundColor = backgroundColor
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
         gradientLayer.frame.size = self.resturantView.frame.size
         gradientLayer.cornerRadius = 10
         gradientLayer.colors =
            [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(1).cgColor]
        //Use diffrent colors
        resturantView.layer.insertSublayer(gradientLayer, at: 0)
        resturantView.allRoundedConrners()
        locationsLabel.roundCorners(corners: [.allCorners],raduis: 10)
    }
    
    private func configureLocationLabel() {
        locationsLabel.isUserInteractionEnabled = true
        locationsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationLabelTapped)))
    }
    
    @objc func locationLabelTapped() {
        
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let MapVC = storyboard.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        MapVC.modalPresentationStyle = .fullScreen
        self.present(MapVC, animated: true, completion: nil)
    }
    
    private func setupRestaurantTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(restaurantViewTapped(_:)))
//        resturantView.isUserInteractionEnabled = true
        if flag == true {
            resturantView.isUserInteractionEnabled = true
        } else {
            resturantView.isUserInteractionEnabled = false
        }
        resturantView.addGestureRecognizer(tapGesture)
    }
    
    @objc func restaurantViewTapped(_ sender : UITapGestureRecognizer){
        performSegue(withIdentifier: "ResVC", sender: nil)
        //        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        //        let RestaurantViewController = storyBoard.instantiateViewController(withIdentifier: "RestaurantVC") as! RestaurantViewController
        //        self.navigationController?.pushViewController(RestaurantViewController, animated:true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ResVC":
            let RestaurantViewController = segue.destination as! RestaurantViewController
            RestaurantViewController.navigationItem.title = locationsLabel.text
        default:
            print("none")
        }
    }
}

// MARK: - Location Permission
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let locationAuthorization = manager.authorizationStatus
        switch locationAuthorization {
        case .authorizedAlways, .authorizedWhenInUse:
            flag = true
        case .denied, .notDetermined:
            showAlert(title: "No Location", message: "Please provide us your location")
            flag = false
        default:
            break
        }
    }
}
