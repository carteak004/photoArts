//
//  CheckoutViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 08/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //var sentSubTotal:Double!
    
    let shippingMethod = ["Standard", "Priority", "Expedited", "Rush"]
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shippingMethodPriceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dateOfDeliveryLabel: UILabel!
    @IBOutlet weak var shippingMethodPickerView: UIPickerView!
    @IBOutlet weak var priceView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        priceView.layer.borderWidth = 1
        priceView.layer.borderColor = UIColor.gray.cgColor
        
        subtotalLabel.text = "$\(CartData.totalPrice).00"
        updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Picker view delegate and datasource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shippingMethod.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shippingMethod[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    
    /*adopted from https://stackoverflow.com/questions/7185440/how-to-change-the-font-size-in-uipickerview to change the font of the picker view. */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        
        if let v = view {
            label = v as! UILabel
        }
        
        label.font = UIFont(name: "System", size: 17)
        label.textColor = UIColor.black
        label.text = shippingMethod[row]
        label.textAlignment = .center
        
        return label
    }
    
    
    // MARK - User defined functions
    
    //function to update the cost and delivery date based on the shipping method selected
    func updateLabel()
    {
        let pickerRow = shippingMethodPickerView.selectedRow(inComponent: 0)
        
        switch pickerRow {
        case 0:
            shippingMethodPriceLabel.text = "$19.95"
            dateOfDeliveryLabel.text = shippingDateandPrice(lag:12, price:19.95)
            break
        case 1:
            shippingMethodPriceLabel.text = "$24.95"
            dateOfDeliveryLabel.text = shippingDateandPrice(lag:10, price:24.95)
            break
        case 2:
            shippingMethodPriceLabel.text = "$34.95"
            dateOfDeliveryLabel.text = shippingDateandPrice(lag:8, price:34.95)
            break
        case 3:
            shippingMethodPriceLabel.text = "$50.00"
            
            dateOfDeliveryLabel.text = shippingDateandPrice(lag:5, price:50.00)
            break
        default:
            shippingMethodPriceLabel.text = "$19.95"
            dateOfDeliveryLabel.text = shippingDateandPrice(lag:12, price:19.95)
            break
        }
    }
    
    //function to estimate the delivery date
    func shippingDateandPrice(lag:Int, price:Double) -> String
    {
        totalLabel.text = "$\(Double(CartData.totalPrice) + price)"
        
        /*code adopted from https://stackoverflow.com/questions/39513258/get-current-date-in-swift-3 */
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        return "\(components.month!)/\(components.day! + lag)/\(components.year!)"
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shipping2"
        {
            let AddressVC = segue.destination as! ShippingAddressViewController
            
            var numberOfItems = 0
            
            for item in CartData.sharedInstance
            {
                numberOfItems += item.quantity
            }
            
            AddressVC.shippingMethod = shippingMethod[shippingMethodPickerView.selectedRow(inComponent: 0)]
            AddressVC.items = numberOfItems
            AddressVC.price = totalLabel.text
            AddressVC.date = dateOfDeliveryLabel.text
        }
     
    }

}
