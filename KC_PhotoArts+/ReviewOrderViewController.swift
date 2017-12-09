//
//  ReviewOrderViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/15/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 The view implementing this class lets the user to review all 
 the information one last time before placing the order. Once 
 the user places and order, the app will prompt to send an 
 e-mail confirmation.
 **************************************************************/

import UIKit
import MessageUI
import CoreData

class ReviewOrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
   


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
    
    @IBAction func placeOrderBarButtonItem(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure to place the Order?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Place Order", style: UIAlertActionStyle.default){ action in
            if !ValidationModel.sessionIsOff
            {
                self.changeStatus(status: "paid")
            }
            self.sendEmail()
        })
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            
            if !ValidationModel.sessionIsOff
            {
                self.changeStatus(status: "complete")
            }
            
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        CartData.sharedInstance.removeAll()
        CheckoutCart.chekOutData = CheckoutCart()
        CartData.totalPrice = 0
        performSegue(withIdentifier: "mainVC", sender: self)
    }
    
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
        shippingAddressLabel.text = "\(CheckoutCart.chekOutData.firstName) \(CheckoutCart.chekOutData.lastName) \r\n\(CheckoutCart.chekOutData.streetAddress) \r\n\(CheckoutCart.chekOutData.city) \r\n\(CheckoutCart.chekOutData.state) - \(CheckoutCart.chekOutData.zipCode)"
        
        //Payment Method
        nameOnCardLabel.text = CheckoutCart.chekOutData.NameOnCard
        cardNumberLabel.text = CheckoutCart.chekOutData.cardNumber
        expiryLabel.text = CheckoutCart.chekOutData.expiryDate
        securityCodeLabel.text = CheckoutCart.chekOutData.securityCode
        
        //Billing Address
        billingAddressLabel.text = "\(CheckoutCart.chekOutData.billingStreerAddress) \r\n\(CheckoutCart.chekOutData.billingCity) \r\n\(CheckoutCart.chekOutData.billingCity) - \(CheckoutCart.chekOutData.billingZipCode)"
        
        //Tab Bar
        totalBarButtonItem.setItem(total: CheckoutCart.chekOutData.price)
    }
    
    func changeStatus(status:String)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0{
                for items in results as! [NSManagedObject] {
                    if items.value(forKey: "username") as? String == ValidationModel.username{
                       items.setValue(status, forKey: "status")
                        
                        ad.saveContext()
                    }
                }
            }
            print("Found \(results.count) users")
        } catch  {
            print("Fetched Data Error!")
        }
    }
    
    func sendEmail()
    {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([CheckoutCart.chekOutData.emailId])
        mailVC.setBccRecipients(["class1photoarts@gmail.com"])
        mailVC.setSubject("Purchase Confirmation from KC-PhotoArts+ team")
        mailVC.setMessageBody(self.messageBody(), isHTML: false)
        
        //present the view controller modally
        if MFMailComposeViewController.canSendMail() {
            self.present(mailVC, animated: true, completion: nil)
        }
    }
    
    func messageBody() -> String
    {
        var index = 0
        let orderDate:String!
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        orderDate = "\(components.month!)/\(components.day!)/\(components.year!)"
        
        var cartDetails:String = "Hey \(CheckoutCart.chekOutData.firstName) \(CheckoutCart.chekOutData.lastName). Here is the summary for your Order placed on \(orderDate):\nItems Purchased:\n"
        
        for item in CartData.sharedInstance
        {
            index += 1
            cartDetails.append("\(index). ")
            cartDetails.append(" Item Name: \(item.itemName!)\n")
            cartDetails.append(" Item Price: \(item.itemPrice!)\n")
            cartDetails.append(" Quantity: \(item.quantity!)\n\n\n")
        }
        
        cartDetails.append("\(shippingOptionsDescriptionLabel.text!)\n\n\n")
        cartDetails.append("Shipping Address:\n\(shippingAddressLabel.text!)\n\n\n")
        cartDetails.append("Payment done from card ending with \(String(CheckoutCart.chekOutData.cardNumber.characters.suffix(4)))\n\n\n")
        cartDetails.append("Billing Address:\n\(billingAddressLabel.text!)")
        
        return cartDetails
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
