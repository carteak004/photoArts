//
//  PaymentViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 14/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 The view implementing this class lets user to enter payment 
 details.
 **************************************************************/

import UIKit

class PaymentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var shippingOptionsLabel: UILabel!
    @IBOutlet weak var shippingOptionsDescriptionLabel: UILabel!
    
    @IBOutlet weak var shippingAddressLabel: UILabel!
    
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var addressSwitch: UISwitch!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expiryTextField: UITextField!
    @IBOutlet weak var securityCodeTextField: UITextField!
    
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var securityCodeLabel: UILabel!
    
    @IBOutlet weak var billingStreetLabel: UILabel!
    @IBOutlet weak var billingCityLabel: UILabel!
    @IBOutlet weak var billingStateLabel: UILabel!
    @IBOutlet weak var billingZipLabel: UILabel!
    
    @IBOutlet weak var totalBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var reviewOrderBarButtonItem: UIBarButtonItem!
    
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
            //print("Switch is ON")
            valueAssignments(hide: true, street: CheckoutCart.chekOutData.streetAddress, city: CheckoutCart.chekOutData.city, state: CheckoutCart.chekOutData.state, zip: CheckoutCart.chekOutData.zipCode)
            //reviewOrderBarButtonItem.isEnabled = true
            ValidationModel.validationObject.billingStreetFlag = true
            ValidationModel.validationObject.billingCityFlag = true
            ValidationModel.validationObject.billingStateFlag = true
            ValidationModel.validationObject.billingZipFlag = true
            validate()
        }
        else{
            //performSegue(withIdentifier: "modifyBilling", sender: self)
            //print("Switch is OFF")
            valueAssignments(hide: false, street: CheckoutCart.chekOutData.billingStreerAddress, city: CheckoutCart.chekOutData.billingCity, state: CheckoutCart.chekOutData.billingState, zip: CheckoutCart.chekOutData.billingZipCode)
            //reviewOrderBarButtonItem.isEnabled = false
            if CheckoutCart.chekOutData.billingStreerAddress == "" || CheckoutCart.chekOutData.billingCity == "" || CheckoutCart.chekOutData.billingState == "" || CheckoutCart.chekOutData.billingZipCode == ""
            {
                ValidationModel.validationObject.billingStreetFlag = false
                ValidationModel.validationObject.billingCityFlag = false
                ValidationModel.validationObject.billingStateFlag = false
                ValidationModel.validationObject.billingZipFlag = false
                validate()
            }
            validate()
        }
    }
    
    @IBAction func reviewOrder(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "reviewOrder", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ValidationModel.validationObject.nameOnCardFlag = true
        ValidationModel.validationObject.billingStreetFlag = true
        ValidationModel.validationObject.billingCityFlag = true
        ValidationModel.validationObject.billingStateFlag = true
        ValidationModel.validationObject.billingZipFlag = true
        validate()
        
        
        
        
        //Load the outlets
        shippingOptionsLabel.text = "1. Shipping Options (\(CheckoutCart.chekOutData.items) items)"
        shippingOptionsDescriptionLabel.text = "\(CheckoutCart.chekOutData.shippingMethod) Shipping. Arrives on \(CheckoutCart.chekOutData.date)"
        shippingAddressLabel.text = "\(CheckoutCart.chekOutData.firstName) \(CheckoutCart.chekOutData.lastName) \r\n\(CheckoutCart.chekOutData.streetAddress) \r\n\(CheckoutCart.chekOutData.city) \r\n\(CheckoutCart.chekOutData.state) - \(CheckoutCart.chekOutData.zipCode)"
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
        
        nameOnCardTextField.text = CheckoutCart.chekOutData.NameOnCard
        cardNumberTextField.text = CheckoutCart.chekOutData.cardNumber
        expiryTextField.text = CheckoutCart.chekOutData.expiryDate
        securityCodeTextField.text = CheckoutCart.chekOutData.securityCode
        
        billingStreetAddressTextField.text = CheckoutCart.chekOutData.billingStreerAddress
        billingCityTextField.text =  CheckoutCart.chekOutData.billingCity
        billingStateTextField.text = CheckoutCart.chekOutData.billingState
        billingZipCodeTextField.text = CheckoutCart.chekOutData.billingZipCode
        
        nameOnCardTextField.text = "\(CheckoutCart.chekOutData.firstName) \(CheckoutCart.chekOutData.lastName)"
        cardNumberTextField.text = CheckoutCart.chekOutData.cardNumber
        expiryTextField.text = CheckoutCart.chekOutData.expiryDate
        securityCodeTextField.text = CheckoutCart.chekOutData.securityCode
        
        valueAssignments(hide: true, street: CheckoutCart.chekOutData.streetAddress, city: CheckoutCart.chekOutData.city, state: CheckoutCart.chekOutData.state, zip: CheckoutCart.chekOutData.zipCode)
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
        switch textField
        {
        case nameOnCardTextField:
            cardNumberTextField.becomeFirstResponder()
            validate()
        case cardNumberTextField:
            expiryTextField.becomeFirstResponder()
            validate()
        case expiryTextField:
            securityCodeTextField.becomeFirstResponder()
            validate()
        case securityCodeTextField:
            securityCodeTextField.resignFirstResponder()
            validate()
        case billingStreetAddressTextField:
            billingCityTextField.becomeFirstResponder()
            validate()
        case billingCityTextField:
            billingStateTextField.becomeFirstResponder()
            validate()
        case billingStateTextField:
            billingZipCodeTextField.becomeFirstResponder()
            validate()
        case billingZipCodeTextField:
            billingZipCodeTextField.resignFirstResponder()
            validate()
        default:
            securityCodeTextField.resignFirstResponder()
            validate()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField
        {
        case nameOnCardTextField:
            validateName(name: nameOnCardTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 80)
        case cardNumberTextField:
            validateCardNumber(cardNumber: cardNumberTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 80)
        case expiryTextField:
            validateExpiry(expiry: expiryTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 80)
        case securityCodeTextField:
            validateSecurityCode(cvv: securityCodeTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 80)
        case billingStreetAddressTextField:
            validateAddress(address: billingStreetAddressTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 150)
        case billingCityTextField:
            validateCity(city: billingCityTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 150)
        case billingStateTextField:
            validateState(state: billingStateTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 150)
        case billingZipCodeTextField:
            validateZip(zip: billingZipCodeTextField.text!)
            validate()
            animateViewMoving(up: false, moveValue: 150)
        default:
            break
        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField
        {
        case nameOnCardTextField:
            animateViewMoving(up: true, moveValue: 80)
        case cardNumberTextField:
            animateViewMoving(up: true, moveValue: 80)
        case expiryTextField:
            animateViewMoving(up: true, moveValue: 80)
        case securityCodeTextField:
            animateViewMoving(up: true, moveValue: 80)
        case billingStreetAddressTextField:
            animateViewMoving(up: true, moveValue: 150)
        case billingCityTextField:
            animateViewMoving(up: true, moveValue: 150)
        case billingStateTextField:
            animateViewMoving(up: true, moveValue: 150)
        case billingZipCodeTextField:
            animateViewMoving(up: true, moveValue: 150)
        default:
            break
        }
    }
    
    // MARK: - User defined functions
    
    //function to move view up or down when keyboard is present
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
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
        
        validate()
    }
    
    func validateName(name:String)
    {
        if name == ""
        {
            nameOnCardLabel.text = "❗️Please enter your Name"
            nameOnCardLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.nameOnCardFlag = false
        }
        else{
            nameOnCardLabel.text = "Name on the Card"
            nameOnCardLabel.textColor = UIColor.black
            //continueButtonLabel.isEnabled = true
            ValidationModel.validationObject.nameOnCardFlag = true
        }
    }
    
    func validateCardNumber(cardNumber:String)
    {
        if cardNumber == ""
        {
            cardNumberLabel.text = "❗️Please enter a Card Number"
            cardNumberLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.cardNumberFlag = false
        }
        else{
            if cardNumber.characters.count > 16 || cardNumber.characters.count < 15
            {
                cardNumberLabel.text = "❗️Please enter a valid Card Number"
                cardNumberLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.cardNumberFlag = false
            }
            else
            {
                cardNumberLabel.text = "Card Number"
                cardNumberLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.cardNumberFlag = true
            }
        }
    }
    
    func validateExpiry (expiry: String)
    {
        if expiry == ""
        {
            expiryDateLabel.text = "❗️Expiry required"
            expiryDateLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.expiryFlag = false
        }
        else{
            if expiry.characters.count != 6
            {
                expiryDateLabel.text = "❗️Invalid Expiry"
                expiryDateLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.expiryFlag = false
            }
            else
            {
                expiryDateLabel.text = "Valid Thru"
                expiryDateLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.expiryFlag = true
            }
        }
    }
    
    func validateSecurityCode (cvv: String)
    {
        if cvv == ""
        {
            securityCodeLabel.text = "❗️CVV required"
            securityCodeLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.securityCodeFlag = false
        }
        else{
            if cvv.characters.count > 4 || cvv.characters.count < 3
            {
                securityCodeLabel.text = "❗️Invalid CVV"
                securityCodeLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.securityCodeFlag = false
            }
            else
            {
                securityCodeLabel.text = "Security Code"
                securityCodeLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.securityCodeFlag = true
            }
        }
    }
    
    func validateAddress(address:String)
    {
        if address == ""
        {
            billingStreetLabel.text = "❗️Please enter an Address"
            billingStreetLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.billingStreetFlag = false
        }
        else{
            billingStreetLabel.text = "Address"
            billingStreetLabel.textColor = UIColor.black
            //continueButtonLabel.isEnabled = true
            ValidationModel.validationObject.billingStreetFlag = true
        }
    }
    
    func validateCity(city:String)
    {
        if city == ""
        {
            billingCityLabel.text = "❗️City Required"
            billingCityLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.billingCityFlag = false
        }
        else{
            let cityTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexText)
            let matchAddreess = cityTest.evaluate(with: city)
            if(!matchAddreess)
            {
                billingCityLabel.text = "❗️Invalid City"
                billingCityLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.billingCityFlag = false
            }
            else{
                billingCityLabel.text = "City"
                billingCityLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.billingCityFlag = true
            }
        }
    }
    
    func validateState(state:String)
    {
        if state == ""
        {
            billingStateLabel.text = "❗️State"
            billingStateLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.billingStateFlag = false
        }
        else{
            let stateTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexState)
            let matchAddreess = stateTest.evaluate(with: state)
            if(!matchAddreess)
            {
                billingStateLabel.text = "❗️State"
                billingStateLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.billingStateFlag = false
            }
            else{
                billingStateLabel.text = "State"
                billingStateLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.billingStateFlag = true
            }
        }
    }
    
    func validateZip(zip:String)
    {
        if zip == ""
        {
            billingZipLabel.text = "❗️Zip required"
            billingZipLabel.textColor = UIColor.red
            //continueButtonLabel.isEnabled = false
            ValidationModel.validationObject.billingZipFlag = false
        }
        else{
            let zipTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexZip)
            let matchAddreess = zipTest.evaluate(with: zip)
            if(!matchAddreess)
            {
                billingZipLabel.text = "❗️Invalid Zip"
                billingZipLabel.textColor = UIColor.red
                //continueButtonLabel.isEnabled = false
                ValidationModel.validationObject.billingZipFlag = false
            }
            else{
                billingZipLabel.text = "Zip Code"
                billingZipLabel.textColor = UIColor.black
                //continueButtonLabel.isEnabled = true
                ValidationModel.validationObject.billingZipFlag = true
            }
        }
    }
    
    func validate()
    {
        if ValidationModel.validationObject.nameOnCardFlag && ValidationModel.validationObject.cardNumberFlag && ValidationModel.validationObject.expiryFlag && ValidationModel.validationObject.securityCodeFlag && ValidationModel.validationObject.billingStreetFlag && ValidationModel.validationObject.billingCityFlag && ValidationModel.validationObject.billingStateFlag && ValidationModel.validationObject.billingZipFlag
        {
            reviewOrderBarButtonItem.isEnabled = true
        }
        else
        {
            reviewOrderBarButtonItem.isEnabled = false
        }
    }
    
    // MARK - Unwind Segue
    @IBAction func editPayment (_ segue:UIStoryboardSegue)
    {
        reviewOrderBarButtonItem.isEnabled = true
    }
    
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
