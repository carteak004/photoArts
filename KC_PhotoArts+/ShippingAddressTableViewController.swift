//
//  ShippingAddressTableViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/9/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ShippingAddressTableViewController: UITableViewController, UITextFieldDelegate {
    
    var items:Int!
    var date:String!
    var shippingMethod:String!
    var price:String!
    
    
    @IBOutlet weak var shippingTypeLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        shippingTypeLabel.text = "Shipping Type: \(shippingMethod!)"
        totalItemsLabel.text = "Total Items: \(items!)"
        totalPriceLabel.text = "Total Price: \(price!)"
        deliveryDateLabel.text = "Est. Delivery Date: \(date!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
