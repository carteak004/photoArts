//
//  ShippingAddressViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/9/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ShippingAddressViewController: UIViewController, UITextFieldDelegate {
    
    // regex variables
    let regexEmail = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
    let regexPhone = "^[0-9]{6,15}$"
    let regexName = "^[a-zA-Z]+$"
    
    let validateFlag = true
    
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
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    
    
    @IBOutlet weak var totalBarButtonItem: UIBarButtonItem!
    
    @IBAction func continueButton(_ sender: UIBarButtonItem) {
        if validateEmail(email: emailTextField.text!) || validateFirstName(firstName: firstNameTextField.text!) || validateLastName(lastName: lastNameTextField.text!) || validatePhoneNumber(phone: phoneNumberTextField.text!)
        {
        performSegue(withIdentifier: "shipping3", sender: self)
        }
    }
    
    
    
    func validateEmail(email: String) -> Bool
    {
        if email == ""
        {
            emailLabel.text =  "❗️Please enter your e-mail address"
            return !validateFlag
        }
        else{
            let emailTest = NSPredicate(format: "SELF MATCHES %@", regexEmail)
            let matchEmailId = emailTest.evaluate(with: email)
            if(!matchEmailId)
            {
                emailLabel.text = "❗️Please enter a valid Email Address"
                return !validateFlag
            }
            else
            {
                emailLabel.text = "E-Mail"
                return validateFlag
            }
        }
    }

    func validatePhoneNumber(phone: String) -> Bool
    {
        if phone == ""
        {
            phoneNumberLabel.text = "❗️Please enter a Phone Number"
            return !validateFlag
        }
        else{
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", regexPhone)
            let matchPhone = phoneTest.evaluate(with: phone)
            if(!matchPhone)
            {
                phoneNumberLabel.text = "❗️Please enter a valid Phone Number"
                return !validateFlag
            }
            else{
                phoneNumberLabel.text = "Phone Number"
                return validateFlag
            }
        }
    }
    
    func validateFirstName(firstName: String) -> Bool
    {
        if firstName == ""
        {
            firstNameLabel.text = "❗️Please enter your First Name"
            return !validateFlag
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", regexName)
            let matchNameId = nameTest.evaluate(with: firstName)
            if(!matchNameId)
            {
                firstNameLabel.text = "❗️Please enter a valid First Name"
                return !validateFlag
            }
            else{
                firstNameLabel.text = "First Name"
                return validateFlag
            }
        }
    }
    
    func validateLastName(lastName: String) -> Bool
    {
        if lastName == ""
        {
            lastNameLabel.text = "❗️Please enter your Last Name"
            return !validateFlag
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", regexName)
            let matchNameId = nameTest.evaluate(with: lastName)
            if(!matchNameId)
            {
                lastNameLabel.text = "❗️Please enter a valid Last Name"
                return !validateFlag
            }
            else{
                lastNameLabel.text = "Last Name"
                return validateFlag
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to move view up when tapped on keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        shippingOptionsLabel.text = "1. Shipping Options (\(CheckoutCart.chekOutData.items) items)"
        shippingOptionsDescriptionLabel.text = "\(CheckoutCart.chekOutData.shippingMethod) Shipping. Arrives on \(CheckoutCart.chekOutData.date)"
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
        
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
                self.view.frame.origin.y -= keyboardSize.height-50
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y += keyboardSize.height-50
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
