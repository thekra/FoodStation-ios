//
//  HomeViewController.swift
//  HungerStationClone
//
//  Created by Gaida  on 08/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet var resturantView: UIView!
    @IBOutlet var locationsLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationsLabel.text = UserDefaults.standard.string(forKey: "addressLabel") ?? locationsLabel.text
        self.navigationController?.navigationBar.barTintColor = .yellow

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .white

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupRestaurantTap()
        configureLocationLabel()
    }
}


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
        resturantView.isUserInteractionEnabled = true
        resturantView.addGestureRecognizer(tapGesture)
    }
    
    @objc func restaurantViewTapped(_ sender : UITapGestureRecognizer){
        performSegue(withIdentifier: "ResVC", sender: nil)
     
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
