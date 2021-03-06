//
//  MapViewController.swift
//  HungerStationClone
//
//  Created by Thekra Abuhaimed. on 23/03/1442 AH.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var chooseButtonFlag = true
    var lat = 0.0
    var long = 0.0
    var chosenAddressName = ""
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var imagesStackView: UIStackView!
    
    // Address names
    @IBOutlet weak var workAddress: UIImageView!
    @IBOutlet weak var otherAddress: UIImageView!
    @IBOutlet weak var homeAddress: UIImageView!
    @IBOutlet weak var friendAddress: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMapView()
        seupAddressNames()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.mapView.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func setupMapView() {
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        let chooseButtonHeight = self.chooseButton.intrinsicContentSize.height
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: chooseButtonHeight+10 , right: 0)
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            print("\n\n\(address)\n\n\n")
            self.addressLabel.text = lines.joined(separator: "\n")
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func dismissLocation(_ sender: UIBarButtonItem) {
        
        if descriptionView.isHidden == false {
            setupChooseButton()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        if chooseButtonFlag {
            setupDoneButton()
            
        } else {
            
            let coor = Coordinates(latitude: self.lat, longitude: self.long)
            let address = addressLabel.text
            locationAPI.saveLocation(name: chosenAddressName, coordinates: [coor], streetName: address!) { (User, Success) in
                if Success {
                    print("User", User)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        //setup here
                    }
                }
            }
            setupChooseButton()
        }
    }
    
    @IBAction func imagesStackViewSwitcher(_ sender: UISwitch) {
        if sender.isOn {
            imagesStackView.isHidden = false
        } else {
            imagesStackView.isHidden = true
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        let location = locations.last
        let lat = location?.coordinate.latitude
        let long = location?.coordinate.longitude
        
        self.lat = lat ?? 0
        self.long = long ?? 0
        
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: long!, zoom: 17)
        self.mapView?.animate(to: camera)
        
        print("Latitude: ", lat ?? 0.0)
        print("Longitude: ", long ?? 0.0)
        self.locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        chooseButton.alpha = 1
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("didChange")
        chooseButton.alpha = 0.5
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        
        self.lat = latitude
        self.long = longitude
        
        print("latitude", latitude)
        print("longitude", longitude)
    }
}

// MARK: - Additional Functions
extension MapViewController {
    func setupDoneButton() {
        descriptionView.isHidden = false
        chooseButtonFlag = false
        chooseButton.setTitle("Done", for: .normal)
        chooseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        UserDefaults.standard.set(addressLabel.text, forKey: "addressLabel")
    }
    
    func setupChooseButton() {
        descriptionView.isHidden = true
        chooseButtonFlag = true
        chooseButton.setTitle("Choose", for: .normal)
        chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: - handle the address save name
extension MapViewController{
    
    private func seupAddressNames(){
        let addressNames = [workAddress,
                            otherAddress,
                            homeAddress,
                            friendAddress]
       
        addressNames.forEach {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickAddressName(_:)))
            $0?.isUserInteractionEnabled = true
            $0?.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc  func pickAddressName(_ sender: UITapGestureRecognizer) {
        
        if let image = sender.view as? UIImageView {
            switch image.tag {
            case 0:
                chosenAddressName = "Home"
               
            case 1:
                chosenAddressName = "Work"
                
            case 2:
                chosenAddressName = "Friend"
               
            case 3 :
                chosenAddressName = "Others"
            default:
                print("errro")
            }
        }
    }
}
