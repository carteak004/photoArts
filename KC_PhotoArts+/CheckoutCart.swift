//
//  CheckoutCart.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 14/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 class that holds payment details
 **************************************************************/
import UIKit

class CheckoutCart: NSObject {

    static var chekOutData = CheckoutCart()
    
    var items = 0
    var date = ""
    var shippingMethod = ""
    var price = ""
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var emailId = ""
    var streetAddress = ""
    var city = ""
    var state = ""
    var zipCode = ""
    var NameOnCard = ""
    var cardNumber = ""
    var expiryDate = ""
    var securityCode = ""
    var billingStreerAddress = ""
    var billingCity = ""
    var billingState = ""
    var billingZipCode = ""
}
