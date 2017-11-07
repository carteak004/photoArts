//
//  CartViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/6/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //var CartData.sharedInstance = [CartData]()
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOutButtonLabel: UIButton!
    
    
    @IBAction func checkOutButton(_ sender: UIButton) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //CartData.sharedInstance = collectionVC.shoppingCart
        if CartData.sharedInstance.count == 0
        {
            cartTableView.isHidden = true
            emptyLabel.isHidden = false
            print("empty")
        }
        else{
            cartTableView.isHidden = false
            emptyLabel.isHidden = true
            print("not empty")
        }
        print(CartData.sharedInstance.count)
        cartTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("load")
        //print(CartData.sharedInstance.count)
        //print(CartData.sharedInstance[0].quantity)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view source and delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartData.sharedInstance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! CartTableViewCell
        
        let cartItem = CartData.sharedInstance[indexPath.row]
        
        cell.artImageView.image = cartItem.itemImageURL.loadImage()
        cell.nameLabel.text = cartItem.itemName
        cell.frameLabel.text = "Frame: \(cartItem.frame!)"
        cell.sizeLabel.text = "Size: \(cartItem.size!)"
        cell.priceLabel.text = "Price: $\(cartItem.itemPrice!).00"
        cell.quantityLabel.text = "Quantity: \(cartItem.quantity!)"
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
