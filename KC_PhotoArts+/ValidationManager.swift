//
//  ValidationManager.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 18/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ValidationManager: NSObject {

    let regexEmail = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
    let regexPhone = "^[0-9]{6,15}$"
    let regexName = "^[a-zA-Z]+$"
    
    
    func validateEmail(email: String) -> String
    {
        var validationError: String? = nil
        
        if email == ""
        {
            validationError = "Please enter your e-mail address"
        }
        else{
            let emailTest = NSPredicate(format: "SELF MATCHES %@", regexEmail)
            let matchEmailId = emailTest.evaluate(with: email)
            if(!matchEmailId)
            {
                validationError = "Please enter a valid Email Address"
            }
        }
        
        return validationError!
    }
    
    func validatePhoneNumber(phone: String) -> String
    {
        var validationError: String? = nil
        
        if phone == ""
        {
            validationError = "Please enter a Phone Number"
        }
        else{
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", regexPhone)
            let matchPhone = phoneTest.evaluate(with: phone)
            if(!matchPhone)
            {
                validationError = "Please enter a valid Phone Number"
            }
        }
        
        return validationError!
    }
    
    func validateName(name: String) -> String
    {
        var validationError: String? = nil
        
        if name == ""
        {
            validationError = "Please enter your Name"
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", regexName)
            let matchNameId = nameTest.evaluate(with: name)
            if(!matchNameId)
            {
                validationError = "Please enter a valid Name"
            }
        }
        
        return validationError!
    }

}
