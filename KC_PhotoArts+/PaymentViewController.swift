//
//  PaymentViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 14/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var shippingOptionsLabel: UILabel!
    @IBOutlet weak var shippingOptionsDescriptionLabel: UILabel!
    
    @IBOutlet weak var shippingAddressLabel: UILabel!
    
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var addressSwitch: UISwitch!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expiryTextField: UITextField!
    @IBOutlet weak var securityCodeTextField: UITextField!
    
    @IBOutlet weak var totalBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var billingStreetAddressTextField: UITextField!
    @IBOutlet weak var billingCityTextField: UITextField!
    @IBOutlet weak var billingStateTextField: UITextField!
    @IBOutlet weak var billingZipCodeTextField: UITextField!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    @IBAction func addressToggleSwitch(_ sender: UISwitch) {
        if addressSwitch.isOn
        {
            print("Switch is ON")
            valueAssignments(hide: true, street: CheckoutCart.chekOutData.streetAddress, city: CheckoutCart.chekOutData.city, state: CheckoutCart.chekOutData.state, zip: CheckoutCart.chekOutData.zipCode)
        }
        else{
            //performSegue(withIdentifier: "modifyBilling", sender: self)
            print("Switch is OFF")
            valueAssignments(hide: false, street: CheckoutCart.chekOutData.billingStreerAddress, city: CheckoutCart.chekOutData.billingCity, state: CheckoutCart.chekOutData.billingState, zip: CheckoutCart.chekOutData.billingZipCode)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //to move view up when tapped on keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //Load the outlets
        shippingOptionsLabel.text = "1. Shipping Options (\(CheckoutCart.chekOutData.items) items)"
        shippingOptionsDescriptionLabel.text = "\(CheckoutCart.chekOutData.shippingMethod) Shipping. Arrives on \(CheckoutCart.chekOutData.date)"
        shippingAddressLabel.text = "\(CheckoutCart.chekOutData.firstName) \(CheckoutCart.chekOutData.lastName) \r\n \(CheckoutCart.chekOutData.streetAddress) \r\n \(CheckoutCart.chekOutData.city) \r\n \(CheckoutCart.chekOutData.state) - \(CheckoutCart.chekOutData.zipCode)"
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
        
        nameOnCardTextField.text = CheckoutCart.chekOutData.NameOnCard
        cardNumberTextField.text = CheckoutCart.chekOutData.cardNumber
        expiryTextField.text = CheckoutCart.chekOutData.expiryDate
        securityCodeTextField.text = CheckoutCart.chekOutData.securityCode
        
        billingStreetAddressTextField.text = CheckoutCart.chekOutData.billingStreerAddress
        billingCityTextField.text =  CheckoutCart.chekOutData.billingCity
        
        valueAssignments(hide: true, street: CheckoutCart.chekOutData.streetAddress, city: CheckoutCart.chekOutData.city, state: CheckoutCart.chekOutData.state, zip: CheckoutCart.chekOutData.zipCode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - functions to move view up when keyboard is present
    /* code adopted from https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift?answertab=votes#tab-top */
    func keyboardWillShow(notification:NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= keyboardSize.height-30
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y += keyboardSize.height-30
            }
        }
    }
    
    
    //MARK: - Delegate function to hide keyboard when tapped outside the field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
    // MARK: - User defined functions
    
    //function to show/hide and assign values to billing address controls
    func valueAssignments(hide:Bool, street:String, city:String, state:String, zip:String)
    {
        billingStreetAddressTextField.isHidden = hide
        billingCityTextField.isHidden = hide
        billingStateTextField.isHidden = hide
        billingZipCodeTextField.isHidden = hide
        streetLabel.isHidden = hide
        cityLabel.isHidden = hide
        stateLabel.isHidden = hide
        zipCodeLabel.isHidden = hide
        
        billingStreetAddressTextField.text = street
        billingCityTextField.text = city
        billingStateTextField.text = state
        billingZipCodeTextField.text = zip
    }
    
    // MARK - Unwind Segue
    @IBAction func editPayment (_ segue:UIStoryboardSegue)
    {}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewOrder"
        {
            CheckoutCart.chekOutData.cardNumber = cardNumberTextField.text!
            CheckoutCart.chekOutData.NameOnCard = nameOnCardTextField.text!
            CheckoutCart.chekOutData.expiryDate = expiryTextField.text!
            CheckoutCart.chekOutData.securityCode = securityCodeTextField.text!
            
            CheckoutCart.chekOutData.billingStreerAddress = billingStreetAddressTextField.text!
            CheckoutCart.chekOutData.billingCity = billingCityTextField.text!
            CheckoutCart.chekOutData.billingState = billingStateTextField.text!
            CheckoutCart.chekOutData.billingZipCode = billingZipCodeTextField.text!
        }
    }
    

}
