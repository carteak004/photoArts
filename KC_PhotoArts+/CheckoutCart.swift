//
//  CheckoutCart.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 14/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class CheckoutCart: NSObject {

    static var chekOutData = CheckoutCart()
    
    var items:Int!
    var date:String!
    var shippingMethod:String!
    var price:String!
    var firstName:String!
    var lastName:String!
    var phoneNumber:String!
    var emailId:String!
    var streetAddress:String!
    var city:String!
    var state:String!
    var zipCode:String!
    var NameOnCard:String!
    var cardNumber:String!
    var expiryDate:String!
    var securityCode:String!
    
}
