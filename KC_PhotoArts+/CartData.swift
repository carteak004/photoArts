//
//  CartData.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/6/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class CartData: NSObject {

    static var sharedInstance = [CartData]() /*https://stackoverflow.com/questions/27651507/passing-data-between-tab-viewed-controllers-in-swift */ //to store cart items
    static var totalPrice:Int = 0 //to store total price of items in the cart
    
    static var itemQuantity = 0
    
    var quantity:Int!
    var size:String!
    var frame:String!
    var itemPrice:Int!
    var itemTotal:Int!
    var itemNumber:String!
    var itemName:String!
    var itemImageURL:String!
    
    init(quantity:Int, size:String, frame:String, itemPrice:Int, itemTotal:Int, itemNumber:String, itemName:String, itemImageURL:String)
    {
        self.quantity = quantity
        self.frame = frame
        self.size = size
        self.itemPrice = itemPrice
        self.itemTotal = itemTotal
        self.itemNumber = itemNumber
        self.itemImageURL = itemImageURL
        self.itemName = itemName
    }
    
}
