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
    let regexText = "^[a-zA-Z]+$"
    let regexZip = "\\b\\d{5}(?:-\\d{4})?\\b"
    let regexState = "AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MP|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY"
    let regexStreet = "\\d+[ ](?:[A-Za-z0-9.-]+[ ]?)+(?:Avenue|Lane|Road|Boulevard|Drive|Street|Ave|Dr|Rd|Blvd|Ln|St)\\.?"
    
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
    
    @IBOutlet weak var continueButtonLabel: UIBarButtonItem!
    @IBAction func continueButton(_ sender: UIBarButtonItem) {
        /*
        let valEmail = validateEmail(email: emailTextField.text!)
        let valFName = validateFirstName(firstName: firstNameTextField.text!)
        let valLName = validateLastName(lastName: lastNameTextField.text!)
        let valPhone = validatePhoneNumber(phone: phoneNumberTextField.text!)
        
        if  valFName && valLName && valEmail && valPhone
        {*/
        performSegue(withIdentifier: "shipping3", sender: self)
        //}
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButtonLabel.isEnabled = false
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        
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
        /*
        if textField == lastNameTextField
        {
            phoneNumberTextField.becomeFirstResponder()
        }*/
        
        switch textField
        {
        case firstNameTextField:
            //validateFirstName(firstName: firstNameTextField.text!)
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            //validateLastName(lastName: lastNameTextField.text!)
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            //validatePhoneNumber(phone: phoneNumberTextField.text!)
            emailTextField.becomeFirstResponder()
        case emailTextField:
            //validateEmail(email: emailTextField.text!)
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

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag
        {
        case 1:
            validateFirstName(firstName: firstNameTextField.text!)
        case 2:
            validateLastName(lastName: lastNameTextField.text!)
        case 3:
            validatePhoneNumber(phone: phoneNumberTextField.text!)
        case 4:
            validateEmail(email: emailTextField.text!)
        case 5:
            validateAddress(address: addressTextField.text!)
        case 6:
            validateCity(city: cityTextField.text!)
        case 7:
            validateState(state: stateTextField.text!)
        case 8:
            validateZip(zip: zipCodeTextField.text!)
        default:
            break
        }
        
    }
    
    
    // MARK: - User defined functions for validation
    func validateEmail(email: String)
    {
        if email == ""
        {
            emailLabel.text =  "❗️Please enter your e-mail address"
            continueButtonLabel.isEnabled = false
            //return !validateFlag
        }
        else{
            let emailTest = NSPredicate(format: "SELF MATCHES %@", regexEmail)
            let matchEmailId = emailTest.evaluate(with: email)
            if(!matchEmailId)
            {
                emailLabel.text = "❗️Please enter a valid Email Address"
                continueButtonLabel.isEnabled = false
                //return !validateFlag
            }
            else
            {
                emailLabel.text = "E-Mail"
                continueButtonLabel.isEnabled = true
                //return validateFlag
            }
        }
    }
    
    func validatePhoneNumber(phone: String)
    {
        if phone == ""
        {
            phoneNumberLabel.text = "❗️Please enter a Phone Number"
            continueButtonLabel.isEnabled = false
            //return !validateFlag
        }
        else{
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", regexPhone)
            let matchPhone = phoneTest.evaluate(with: phone)
            if(!matchPhone)
            {
                phoneNumberLabel.text = "❗️Please enter a valid Phone Number"
                continueButtonLabel.isEnabled = false
                //return !validateFlag
            }
            else{
                phoneNumberLabel.text = "Phone Number"
                continueButtonLabel.isEnabled = true
                //return validateFlag
            }
        }
    }
    
    func validateFirstName(firstName: String)
    {
        if firstName == ""
        {
            firstNameLabel.text = "❗️Please enter your First Name"
            continueButtonLabel.isEnabled = false
            //return !validateFlag
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", regexText)
            let matchName = nameTest.evaluate(with: firstName)
            if(!matchName)
            {
                firstNameLabel.text = "❗️Please enter a valid First Name"
                continueButtonLabel.isEnabled = false
                //return !validateFlag
            }
            else{
                firstNameLabel.text = "First Name"
                continueButtonLabel.isEnabled = true
                //return validateFlag
            }
        }
    }
    
    func validateLastName(lastName: String)
    {
        if lastName == ""
        {
            lastNameLabel.text = "❗️Please enter your Last Name"
            continueButtonLabel.isEnabled = false
            //return !validateFlag
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", regexText)
            let matchName = nameTest.evaluate(with: lastName)
            if(!matchName)
            {
                lastNameLabel.text = "❗️Please enter a valid Last Name"
                continueButtonLabel.isEnabled = false
                //return !validateFlag
            }
            else{
                lastNameLabel.text = "Last Name"
                continueButtonLabel.isEnabled = true
                //return validateFlag
            }
        }
    }
    
    func validateAddress(address:String)
    {
        if address == ""
        {
            addressLabel.text = "❗️Please enter an Address"
            continueButtonLabel.isEnabled = false
        }
        else{
            let addressTest = NSPredicate(format: "SELF MATCHES %@", regexStreet)
            let matchAddreess = addressTest.evaluate(with: address)
            if(!matchAddreess)
            {
                addressLabel.text = "❗️Please enter a valid Address"
                continueButtonLabel.isEnabled = false
            }
            else{
                addressLabel.text = "Address"
                continueButtonLabel.isEnabled = true
            }
        }
    }
    
    func validateCity(city:String)
    {
        if city == ""
        {
            cityLabel.text = "❗️Please enter a City"
            continueButtonLabel.isEnabled = false
        }
        else{
            let cityTest = NSPredicate(format: "SELF MATCHES %@", regexText)
            let matchAddreess = cityTest.evaluate(with: city)
            if(!matchAddreess)
            {
                cityLabel.text = "❗️Please enter a valid City"
                continueButtonLabel.isEnabled = false
            }
            else{
                cityLabel.text = "City"
                continueButtonLabel.isEnabled = true
            }
        }
    }
    
    func validateState(state:String)
    {
        if state == ""
        {
            stateLabel.text = "❗️State required"
            continueButtonLabel.isEnabled = false
        }
        else{
            let stateTest = NSPredicate(format: "SELF MATCHES %@", regexState)
            let matchAddreess = stateTest.evaluate(with: state)
            if(!matchAddreess)
            {
                stateLabel.text = "❗️Invalid State"
                continueButtonLabel.isEnabled = false
            }
            else{
                stateLabel.text = "State"
                continueButtonLabel.isEnabled = true
            }
        }
    }
    
    func validateZip(zip:String)
    {
        if zip == ""
        {
            zipcodeLabel.text = "❗️ZIPCode required"
            continueButtonLabel.isEnabled = false
        }
        else{
            let zipTest = NSPredicate(format: "SELF MATCHES %@", regexZip)
            let matchAddreess = zipTest.evaluate(with: zip)
            if(!matchAddreess)
            {
                zipcodeLabel.text = "❗️Invalid ZIPCode"
                continueButtonLabel.isEnabled = false
            }
            else{
                zipcodeLabel.text = "ZIPCode"
                continueButtonLabel.isEnabled = true
            }
        }
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
