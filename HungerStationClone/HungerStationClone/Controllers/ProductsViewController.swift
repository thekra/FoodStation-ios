//
//  ProductsViewController.swift
//  HungerStationClone
//
//  Created by amthal enazi on 24/03/1442 AH.
//

import UIKit

protocol AddToCartDelegate {
    func addToCartFinal(product: Products)
}

class ProductsViewController: UIViewController {

    
    @IBOutlet var AddView: UIView!
    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var increaseButton: UIButton!
    @IBOutlet var quantityLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productLable: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lablecount: UILabel!
    
    var delegate: AddToCartDelegate!
    var product : Products!
    
    var selectedProductPrice : Double = 0.0
    var totalPrice = 0.0
    var quantity = 0.0
    
    var productSelections = [
        ["3pcs musahab Regular","4pcs Chicke Tender","Apple Pie","3pcs musahab Spicy","4pcs Chicken Nuggets","3pc Nacho Cheese Triangle"],
        [ "W/Masameer Key Chain", "W/Herfy Ceramic Mug","W/Herfy Deck Card"],
        ["Pepsi","7 Up", "Mirinda","Diet Pepsi","Mountain Dew"]
    ]
    let sectionsTitle = ["Add Ons", "Add Ons", "Choose Drinks"]
    var checked = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        
        lablecount.text = "\(product.price)"
    }
    
    @IBAction func increaseQuanitity(_ sender: UIButton) {
        calculateTotalPrice(senderTag: sender.tag)
    }
    
    @IBAction func decreaseQuanitity(_ sender: UIButton) {
        calculateTotalPrice(senderTag: sender.tag)
    }
    
    private func calculateTotalPrice(senderTag: Int){
        
        let productPrice = product.price
        
        switch senderTag {
        case 0:
            quantity -= 1
            totalPrice = productPrice * quantity
            
        case 1:
            quantity += 1
            totalPrice = productPrice * quantity
            
        default:
            print("error")
        }
        quantityLabel.text = "\(Int(quantity))"
        lablecount.text = "\(totalPrice)"
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ProductsCellTableViewCell else { return}
        
        cell.CheckMarkButton.image = UIImage(named: "checkmarlQ")
    }
}

extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 20.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productSelections[section].count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductsCellTableViewCell
        
        
        switch indexPath.section {
        
        case 0:
            cell.ProductsCellLabel.text = productSelections[0][indexPath.row]

        case 1:
            cell.ProductsCellLabel.text = productSelections[1][indexPath.row]
            
        case 2:
            cell.ProductsCellLabel.text = productSelections[2][indexPath.row]


        default:
            print("ijoi")
        }
       // let products = Products[[indexPath.section][indexPath.row]]
         
        
//        cell.ProductsCellLabel.text = products.Cell[indexPath.row]
//        cell.CheckMarkButton.image = products.isMarked == true ? UIImage(named: "square") : UIImage(named: "checkmarlQ")
//
        //cell.ProductsCellLabel.text = Products[indexPath.section][indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }

}

struct ProductSelections {
    var selections: [String]
  //  var isMarked: Bool
}

extension ProductsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendProduct" {

            let menuVC = segue.destination as! MenuViewController
            delegate = menuVC
            product.price = totalPrice
            menuVC.product = product
            delegate.addToCartFinal(product: product)


          //  menuVC.cart.append(product)

          //  menuVC.cart.append(selectedProduct!)
        }
    }
    
  
    @objc func addToCart(_ sender: UITapGestureRecognizer) {
//        performSegue(withIdentifier: "sendProduct", sender: nil)
        let menuVC = storyboard?.instantiateViewController(identifier: "MenuVC") as! MenuViewController
        delegate = menuVC
        product.price = totalPrice
        menuVC.product = product
        delegate.addToCartFinal(product: product)
        
        dismiss(animated: true, completion: nil)
//        var selectedProduct = product
//        selectedProduct?.price = totalPrice
//        menuVC.product = selectedProduct!
//      //  menuVC.cart.append(selectedProduct!)
      // present(menuVC, animated: true, completion: nil)

        
       // delegate = menuVC
       // delegate.addToCartFinal(product: product)
//            menuVC.cart.append(product)
      //      menuVC.totalPriceLabel.text = String(totalPrice)
     
      //  menuVC.cart.append(product)
          //  menuVC.modalPresentationStyle = .fullScreen


//            menuVC.addCartView.isHidden = false
    }
    
    func setupUI() {
        AddView.allRoundedConrners()
        AddView.isUserInteractionEnabled = true
        decreaseButton.roundCorners(corners: .allCorners, raduis: 30)
        increaseButton.roundCorners(corners: .allCorners, raduis: 30)

        let tapAddGesture = UITapGestureRecognizer(target: self, action: #selector(addToCart(_:)))
        AddView.addGestureRecognizer(tapAddGesture)
    }
}
