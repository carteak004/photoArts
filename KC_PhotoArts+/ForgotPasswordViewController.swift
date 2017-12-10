//
//  ForgotPasswordViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 12/5/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/**************************************************************
 This view has controls to update password for a given username.
 **************************************************************/



import UIKit
import CoreData

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var continueButtonLabel: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordButtonLabel: UIButton!
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let emailEntered = emailTextField.text!
        
        if verifyEmail(email: emailEntered)
        {
            emailLabel.text = "For user \(emailEntered),"
            hideLabels(flag: false)
        }
        else{
            
            let alert = UIAlertController(title: "Action required", message: "The e-mail entered is not in our records", preferredStyle: .alert)
           /*
            let createAccount = UIAlertAction(title: "Create an Account", style: .default) { (action) in
                self.performSegue(withIdentifier: "signIn", sender: self)
                
            }*/
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                self.emailTextField.text = ""
                self.emailTextField.becomeFirstResponder()
            }
            
            alert.addAction(cancel)
            //alert.addAction(createAccount)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func resetPasswordButtonPressed(_ sender: UIButton) {
        let newPassword = newPasswordTextField.text!
        
        if newPassword != reenterPasswordTextField.text!
        {
            showAlert(title: "Please Verify", message: "Passwords entered do not match")
        }
        else{
            if updatePassword(email: emailTextField.text!)
            {
                //showAlert(title: "Success", message: "Password updated")
                let alert = UIAlertController(title: "Success", message: "Password updated", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel){ (action) in
                    self.performSegue(withIdentifier: "signIn", sender: self)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                showAlert(title: "OOPS", message: "Something went wrong")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLabels(flag: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to show or hide controls.
    func hideLabels(flag:Bool)
    {
        emailTextField.isHidden = !flag
        continueButtonLabel.isHidden = !flag
        emailLabel.isHidden = flag
        newPasswordTextField.isHidden = flag
        reenterPasswordTextField.isHidden = flag
        resetPasswordButtonLabel.isHidden = flag
    }
    
    func showAlert(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    //function to verify if email entered is in the database.
    func verifyEmail(email:String) -> Bool
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0{
                for items in results as! [NSManagedObject] {
                    if let username = items.value(forKey: "username") as? String {
                        if email == username
                        {
                            return true
                        }
                    }
                }
            }
            print("Found \(results.count) users")
        } catch  {
            print("Fetched Data Error!")
        }
        
        return false
    }
    
    func updatePassword(email:String) -> Bool
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false

        do {
            let results =  try context.fetch(request)
            
            if results.count > 0
            {
                for items in results as! [NSManagedObject] {
                    if let username = items.value(forKey: "username") as? String {
                        if email == username
                        {
                            items.setValue(newPasswordTextField.text!, forKey: "password")
                            
                            ad.saveContext()
                            
                            return true
                        }
                    }
                }
            }
        } catch  {
            print("Fetched Data Error!")
        }
        
        return false
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
