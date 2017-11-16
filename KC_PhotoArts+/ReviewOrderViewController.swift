//
//  ReviewOrderViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/15/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ReviewOrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var shippingOptionsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shippingOptionsDescriptionLabel: UILabel!
    @IBOutlet weak var shippingAddressLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var securityCodeLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var billingAddressLabel: UILabel!
    @IBOutlet weak var totalBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLabels() //function to load labels
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Collection view delegate functions
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartData.sharedInstance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! ReviewOrderCVCell
        
        let singleInstance:CartData = CartData.sharedInstance[indexPath.row]
        
        cell.imageView.image = singleInstance.itemImageURL.loadImage()
        cell.quantityLabel.text = "(\(singleInstance.quantity!))"
        
        return cell
    }

    // MARK: - User defined functions
    //function to load labels
    func loadLabels()
    {
        //Shipping Options
        shippingOptionsLabel.text = "1. Shipping Options (\(CheckoutCart.chekOutData.items) items)"
        shippingOptionsDescriptionLabel.text = "\(CheckoutCart.chekOutData.shippingMethod) Shipping. Arrives on \(CheckoutCart.chekOutData.date)"
        
        //Shipping Address
        shippingAddressLabel.text = "\(CheckoutCart.chekOutData.firstName) \(CheckoutCart.chekOutData.lastName) \r\n \(CheckoutCart.chekOutData.streetAddress) \r\n \(CheckoutCart.chekOutData.city) \r\n \(CheckoutCart.chekOutData.state) - \(CheckoutCart.chekOutData.zipCode)"
        
        //Payment Method
        nameOnCardLabel.text = CheckoutCart.chekOutData.NameOnCard
        cardNumberLabel.text = CheckoutCart.chekOutData.cardNumber
        expiryLabel.text = CheckoutCart.chekOutData.expiryDate
        securityCodeLabel.text = CheckoutCart.chekOutData.securityCode
        
        //Billing Address
        billingAddressLabel.text = "\(CheckoutCart.chekOutData.billingStreerAddress) \r\n \(CheckoutCart.chekOutData.billingCity) \r\n \(CheckoutCart.chekOutData.billingCity) - \(CheckoutCart.chekOutData.billingZipCode)"
        
        //Tab Bar
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
