//
//  ShippingAddressViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/9/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 The view implementing this class lets the user to enter 
 shipping address and user details.
 **************************************************************/

import UIKit

class ShippingAddressViewController: UIViewController, UITextFieldDelegate {
    
        
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
        //continueButtonLabel.isEnabled = false
        
        validate()
        
        shippingOptionsLabel.text = "1. Shipping Options (\(CheckoutCart.chekOutData.items) items)"
        shippingOptionsDescriptionLabel.text = "\(CheckoutCart.chekOutData.shippingMethod) Shipping. Arrives on \(CheckoutCart.chekOutData.date)"
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
        
        firstNameTextField.text = CheckoutCart.chekOutData.firstName
        lastNameTextField.text = CheckoutCart.chekOutData.lastName
        addressTextField.text = CheckoutCart.chekOutData.streetAddress
        cityTextField.text = CheckoutCart.chekOutData.city
        stateTextField.text = CheckoutCart.chekOutData.state
        zipCodeTextField.text = CheckoutCart.chekOutData.zipCode
        phoneNumberTextField.text = CheckoutCart.chekOutData.phoneNumber
        emailTextField.text = CheckoutCart.chekOutData.emailId
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /*if textField == zipCodeTextField || textField == cityTextField
        {
            animateViewMoving(up: true, moveValue: 100)
        }*/
        
        switch textField
        {
        case emailTextField:
            animateViewMoving(up: true, moveValue: 50)
        case addressTextField:
            animateViewMoving(up: true, moveValue: 100)
        case cityTextField:
            animateViewMoving(up: true, moveValue: 180)
        case stateTextField:
            animateViewMoving(up: true, moveValue: 180)
        case zipCodeTextField:
            animateViewMoving(up: true, moveValue: 180)
        default:
            break
        }
    }

    
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            validate()
        case 2:
            validateLastName(lastName: lastNameTextField.text!)
            validate()
        case 3:
            validatePhoneNumber(phone: phoneNumberTextField.text!)
            validate()
        case 4:
            validateEmail(email: emailTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 50)
        case 5:
            validateAddress(address: addressTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 100)
        case 6:
            validateCity(city: cityTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 180)
        case 7:
            validateState(state: stateTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 180)
        case 8:
            validateZip(zip: zipCodeTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 180)
        default:
            break
        }
        
    }
    
    
    // MARK: - User defined functions for validation
    
    func validate()
    {
        if ValidationModel.validationObject.emailFlag && ValidationModel.validationObject.phoneFlag && ValidationModel.validationObject.firstNameFlag && ValidationModel.validationObject.lastNameFlag && ValidationModel.validationObject.streetFlag && ValidationModel.validationObject.cityFlag && ValidationModel.validationObject.stateFlag && ValidationModel.validationObject.zipFlag
        {
            continueButtonLabel.isEnabled = true
        }
        else{
            continueButtonLabel.isEnabled = false
        }
    }
    
    func validateEmail(email: String)
    {
        if email == ""
        {
            emailLabel.text =  "❗️Please enter your e-mail address"
            emailLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.emailFlag = false
        }
        else{
            let emailTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexEmail)
            let matchEmailId = emailTest.evaluate(with: email)
            if(!matchEmailId)
            {
                emailLabel.text = "❗️Please enter a valid Email Address"
                emailLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.emailFlag = false
            }
            else
            {
                emailLabel.text = "E-Mail"
                emailLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.emailFlag = true
            }
        }
    }
    
    func validatePhoneNumber(phone: String)
    {
        if phone == ""
        {
            phoneNumberLabel.text = "❗️Please enter a Phone Number"
            phoneNumberLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.phoneFlag = false
        }
        else{
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexPhone)
            let matchPhone = phoneTest.evaluate(with: phone)
            if(!matchPhone)
            {
                phoneNumberLabel.text = "❗️Please enter a valid Phone Number"
                phoneNumberLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.phoneFlag = false
            }
            else{
                phoneNumberLabel.text = "Phone Number"
                phoneNumberLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.phoneFlag = true
            }
        }
    }
    
    func validateFirstName(firstName: String)
    {
        if firstName == ""
        {
            firstNameLabel.text = "❗️Please enter your First Name"
            firstNameLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.firstNameFlag = false
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexText)
            let matchName = nameTest.evaluate(with: firstName)
            if(!matchName)
            {
                firstNameLabel.text = "❗️Please enter a valid First Name"
                firstNameLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.firstNameFlag = false
            }
            else{
                firstNameLabel.text = "First Name"
                firstNameLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.firstNameFlag = true
            }
        }
    }
    
    func validateLastName(lastName: String)
    {
        if lastName == ""
        {
            lastNameLabel.text = "❗️Please enter your Last Name"
            lastNameLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.lastNameFlag = false
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexText)
            let matchName = nameTest.evaluate(with: lastName)
            if(!matchName)
            {
                lastNameLabel.text = "❗️Please enter a valid Last Name"
                lastNameLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.lastNameFlag = false
            }
            else{
                lastNameLabel.text = "Last Name"
                lastNameLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.lastNameFlag = true
            }
        }
    }
    
    func validateAddress(address:String)
    {
        if address == ""
        {
            addressLabel.text = "❗️Please enter an Address"
            addressLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.streetFlag = false
        }
        else{
            addressLabel.text = "Address"
            addressLabel.textColor = UIColor.black
            //continueButtonLabel.isEnabled = true
            ValidationModel.validationObject.streetFlag = true
        }
    }
    
    func validateCity(city:String)
    {
        if city == ""
        {
            cityLabel.text = "❗️Please enter a City"
            cityLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.cityFlag = false
        }
        else{
            let cityTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexText)
            let matchAddreess = cityTest.evaluate(with: city)
            if(!matchAddreess)
            {
                cityLabel.text = "❗️Please enter a valid City"
                cityLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.cityFlag = false
            }
            else{
                cityLabel.text = "City"
                cityLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.cityFlag = true
            }
        }
    }
    
    func validateState(state:String)
    {
        if state == ""
        {
            stateLabel.text = "❗️State required"
            stateLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.stateFlag = false
        }
        else{
            let stateTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexState)
            let matchAddreess = stateTest.evaluate(with: state)
            if(!matchAddreess)
            {
                stateLabel.text = "❗️Invalid State"
                stateLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.stateFlag = false
            }
            else{
                stateLabel.text = "State"
                stateLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.stateFlag = true
            }
        }
    }
    
    func validateZip(zip:String)
    {
        if zip == ""
        {
            zipcodeLabel.text = "❗️ZIPCode required"
            zipcodeLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.zipFlag = false
        }
        else{
            let zipTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexZip)
            let matchAddreess = zipTest.evaluate(with: zip)
            if(!matchAddreess)
            {
                zipcodeLabel.text = "❗️Invalid ZIPCode"
                zipcodeLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.zipFlag = false
            }
            else{
                zipcodeLabel.text = "ZIPCode"
                zipcodeLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.zipFlag = true
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
            CheckoutCart.chekOutData.phoneNumber = phoneNumberTextField.text!
            CheckoutCart.chekOutData.emailId = emailTextField.text!
        }
    }
}
