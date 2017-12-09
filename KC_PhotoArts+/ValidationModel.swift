//
//  ValidationModel.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 24/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 class that holds regex
 **************************************************************/
import UIKit

class ValidationModel: NSObject {

    static var validationObject = ValidationModel()
    
    static var sessionIsOff = true
    static var username = ""
    
    // regex variables
    let regexEmail = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
    let regexPhone = "^[0-9]{6,10}$"
    let regexText = "^[a-zA-Z]+$"
    //let regexName = "/^[A-z ,.'-]+$/i"
    let regexZip = "\\b\\d{5}(?:-\\d{4})?\\b"
    let regexState = "AL|AK|AS|AZ|AR|CA|CO|CT|DE|DC|FM|FL|GA|GU|HI|ID|IL|IN|IA|KS|KY|LA|ME|MH|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|MP|OH|OK|OR|PW|PA|PR|RI|SC|SD|TN|TX|UT|VT|VI|VA|WA|WV|WI|WY"
    //let regexStreet = "\\d+[ ](?:[A-Za-z0-9.-]+[ ]?)+(?:Avenue|Lane|Road|Boulevard|Drive|Street|Ave|Dr|Rd|Blvd|Ln|St)\\.?"
    //let regexStreet = "^\\s*\\S+(?:\\s+\\S+){2}"
    
    var emailFlag = false
    var phoneFlag = false
    var firstNameFlag = false
    var lastNameFlag = false
    var streetFlag = false
    var cityFlag = false
    var stateFlag = false
    var zipFlag = false
    
    var nameOnCardFlag = false
    var cardNumberFlag = false
    var expiryFlag = false
    var securityCodeFlag = false
    
    var billingStreetFlag = false
    var billingCityFlag = false
    var billingStateFlag = false
    var billingZipFlag = false

    var signupFirstNameFlag = false
    var signUpLastNameFlag = false
    var signupEmailFlag = false
    var signupPasswordFlag = false
    var signupRepeatPasswordFlag = false
}
