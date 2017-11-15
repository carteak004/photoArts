//
//  PaymentViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 14/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var addressSwitch: UISwitch!
    @IBAction func addressToggleSwitch(_ sender: UISwitch) {
        if addressSwitch.isOn
        {
            print("Switch is ON")
            CheckoutCart.chekOutData.billingStreerAddress = CheckoutCart.chekOutData.streetAddress
            CheckoutCart.chekOutData.billingCity = CheckoutCart.chekOutData.city
            CheckoutCart.chekOutData.billingState = CheckoutCart.chekOutData.state
            CheckoutCart.chekOutData.billingZipCode = CheckoutCart.chekOutData.zipCode
        }
        else{
            performSegue(withIdentifier: "segModal", sender: self)
            print("Switch is OFF")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //to move view up when tapped on keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShippingAddressViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - functions to move view up when keyboard is present
    /* code adopted from https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift?answertab=votes#tab-top */
    func keyboardWillShow(notification:NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= keyboardSize.height-30
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y += keyboardSize.height-30
            }
        }
    }
    
    
    //MARK: - Delegate function to hide keyboard when tapped outside the field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //MARK: - Unwind segues
    @IBAction func editPayment (_ segue:UIStoryboardSegue)
    {}
    
    @IBAction func unwindtoPayment(_ segue:UIStoryboardSegue)
    {
        addressSwitch.setOn(true, animated: true)
    }

    @IBAction func addBillingAddress(_ segue:UIStoryboardSegue)
    {
        if let billingVC = segue.source as? BillingAddressViewController
        {
            CheckoutCart.chekOutData.billingStreerAddress = billingVC.addressTextField.text!
            CheckoutCart.chekOutData.billingCity = billingVC.cityTextField.text!
            CheckoutCart.chekOutData.billingState = billingVC.stateTextField.text!
            CheckoutCart.chekOutData.billingZipCode = billingVC.zipCodeTextField.text!
        }
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
