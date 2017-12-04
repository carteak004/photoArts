//
//  ArtData.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 29/10/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/**************************************************************
 Class that holds details of an art
 **************************************************************/
import UIKit

class ArtData: NSObject {

    var itemName:String!
    var itemNumber:String!
    var largeImage:String!
    var smallImage:String
    
    init(itemName:String!, itemNumber:String!, largeImage:String!, smallImage:String!)
    {
        self.itemName = itemName
        self.itemNumber = itemNumber
        self.largeImage = largeImage
        self.smallImage = smallImage
    }
}
