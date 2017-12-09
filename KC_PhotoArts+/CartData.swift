//
//  CartData.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/6/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 class that holds the items added to cart
 **************************************************************/

import UIKit

class CartData: NSObject {

    static var sharedInstance = [CartData]() /*https://stackoverflow.com/questions/27651507/passing-data-between-tab-viewed-controllers-in-swift */ //to store cart items
    static var totalPrice:Int64 = 0 //to store total price of items in the cart
    
    
    var quantity:Int64!
    var size:String!
    var frame:String!
    var itemPrice:Int64!
    var itemTotal:Int64!
    var itemNumber:String!
    var itemName:String!
    var itemImageURL:String!
    
    init(quantity:Int64, size:String, frame:String, itemPrice:Int64, itemTotal:Int64, itemNumber:String, itemName:String, itemImageURL:String)
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
