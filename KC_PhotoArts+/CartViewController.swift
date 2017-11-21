//
//  CartViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/6/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //var totalPrice = 0
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOutButtonLabel: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkOutViewUpdate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let cartItem =  CartData.sharedInstance[indexPath.row]
        
        cell.artImageView.image = cartItem.itemImageURL.loadImage()
        cell.nameLabel.text = cartItem.itemName
        cell.frameLabel.text = "Frame: \(cartItem.frame!)"
        cell.sizeLabel.text = "Size: \(cartItem.size!)"
        cell.priceLabel.text = "Price: $\(cartItem.itemPrice!).00"
        cell.quantityLabel.text = "Quantity: \(cartItem.quantity!)"
        
        cell.quantityStepper.value = Double(cartItem.quantity)
        
        return cell
    }
    
    //MARK: - Function to use stepper in the cell
    func changeQuantity(cell: CartTableViewCell, step: Double) {
        cell.quantityLabel.text = "changed"
        cartTableView.reloadData()
    }
    
    /*swipe left to delete feature. adopted from https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            CartData.sharedInstance.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        checkOutViewUpdate()
        //print(CartData.sharedInstance.count)
    }
    
    
    // MARK - User defined functions
    
    //function to update check out view. If there are no items in the cart, it will hide the controls on the screen or else it will display everything.
    
    func checkOutViewUpdate()
    {
        if CartData.sharedInstance.count == 0
        {
            cartTableView.isHidden = true
            emptyLabel.isHidden = false
            checkOutButtonLabel.isHidden = true
            totalPriceLabel.isHidden = true
            priceLabel.isHidden = true
            //print("empty")
        }
        else{
            cartTableView.isHidden = false
            emptyLabel.isHidden = true
            checkOutButtonLabel.isHidden = false
            totalPriceLabel.isHidden = false
            priceLabel.isHidden = false
            // print("not empty")
        }
        //print(CartData.sharedInstance.count)
        cartTableView.reloadData()
        CartData.totalPrice = 0
        //print(CartData.sharedInstance.count)
        for item in CartData.sharedInstance
        {
            CartData.totalPrice += item.quantity * item.itemPrice
        }
        totalPriceLabel.text = "$\(CartData.totalPrice).00"
    }
    
    
    // MARK - Unwind segue
    @IBAction func unwindToCancel(_ segue:UIStoryboardSegue)
    {
        CartData.totalPrice = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkOut"
        {
            let navVc = segue.destination as! UINavigationController
            let checkOutVC = navVc.topViewController as! CheckoutViewController
            let checkOutVC = segue.destination as! CheckoutViewController
            
            checkOutVC.sentSubTotal = Double(totalPrice)
        }
 
        
    }
    */

}
