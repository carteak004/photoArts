//
//  ShippingAddressViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/9/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ShippingAddressViewController: UIViewController, UITextFieldDelegate {
    
    let validationManager = ValidationManager()
    
    @IBOutlet weak var shippingTypeLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var shippingOptionsLabel: UILabel!
    @IBOutlet weak var shippingOptionsDescriptionLabel: UILabel!
    

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var totalBarButtonItem: UIBarButtonItem!
    
    @IBAction func continueButton(_ sender: UIBarButtonItem) {
        CheckoutCart.chekOutData.firstName = firstNameTextField.text!
        CheckoutCart.chekOutData.lastName = lastNameTextField.text!
        CheckoutCart.chekOutData.streetAddress = addressTextField.text!
        CheckoutCart.chekOutData.city = cityTextField.text!
        CheckoutCart.chekOutData.state = stateTextField.text!
        CheckoutCart.chekOutData.zipCode = zipCodeTextField.text!
        CheckoutCart.chekOutData.billingStreerAddress = addressTextField.text!
        CheckoutCart.chekOutData.billingCity = cityTextField.text!
        CheckoutCart.chekOutData.billingState = stateTextField.text!
        CheckoutCart.chekOutData.billingZipCode = zipCodeTextField.text!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to move view up when tapped on keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        shippingOptionsLabel.text = "1. Shipping Options (\(CheckoutCart.chekOutData.items) items)"
        shippingOptionsDescriptionLabel.text = "\(CheckoutCart.chekOutData.shippingMethod) Shipping. Arrives on \(CheckoutCart.chekOutData.date)"
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
        /*shippingTypeLabel.text = "Shipping Type: \(CheckoutCart.chekOutData.shippingMethod)"
        totalItemsLabel.text = "Total Items: \(CheckoutCart.chekOutData.items)"
        totalPriceLabel.text = "Total Price: \(CheckoutCart.chekOutData.price)"
        deliveryDateLabel.text = "Est. Delivery Date: \(CheckoutCart.chekOutData.date)"*/
        
        firstNameTextField.text = CheckoutCart.chekOutData.firstName
        lastNameTextField.text = CheckoutCart.chekOutData.lastName
        addressTextField.text = CheckoutCart.chekOutData.streetAddress
        cityTextField.text = CheckoutCart.chekOutData.city
        stateTextField.text = CheckoutCart.chekOutData.state
        zipCodeTextField.text = CheckoutCart.chekOutData.zipCode
        addressTextField.text = CheckoutCart.chekOutData.billingStreerAddress
        cityTextField.text = CheckoutCart.chekOutData.billingCity
        stateTextField.text = CheckoutCart.chekOutData.billingState
        zipCodeTextField.text = CheckoutCart.chekOutData.billingZipCode

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField
        {
        case firstNameTextField:
            print(validationManager.validateName(name: firstNameTextField.text!))
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            addressTextField.becomeFirstResponder()
        case addressTextField:
            cityTextField.becomeFirstResponder()
        case cityTextField:
            stateTextField.becomeFirstResponder()
        case stateTextField:
            zipCodeTextField.becomeFirstResponder()
        default:
            zipCodeTextField.resignFirstResponder()
        
        }
        return true
    }

    // MARK - Unwind Segue
    @IBAction func editShippingAddress (_ segue:UIStoryboardSegue)
    {}
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shipping3"
        {
            
         CheckoutCart.chekOutData.firstName = firstNameTextField.text!
         CheckoutCart.chekOutData.lastName = lastNameTextField.text!
         CheckoutCart.chekOutData.streetAddress = addressTextField.text!
         CheckoutCart.chekOutData.city = cityTextField.text!
         CheckoutCart.chekOutData.state = stateTextField.text!
         CheckoutCart.chekOutData.zipCode = zipCodeTextField.text!
         CheckoutCart.chekOutData.billingStreerAddress = addressTextField.text!
         CheckoutCart.chekOutData.billingCity = cityTextField.text!
         CheckoutCart.chekOutData.billingState = stateTextField.text!
         CheckoutCart.chekOutData.billingZipCode = zipCodeTextField.text!
            
        }
    }
}
