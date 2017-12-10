//
//  LoginViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 04/12/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 This view has controls to either login or create an account.
 **************************************************************/

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Variables
    var quantity:Int64!
    var size:String!
    var frame:String!
    var itemPrice:Int64!
    var itemTotal:Int64!
    
    //Sign In
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInView: UIView!
    
    //Sign up
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var signupPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var signupPasswordLabel: UILabel!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "cancelLoginToCart", sender: self)
    }
    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let username = eMailTextField.text!
        let password = signupPasswordTextField.text!
        
        print(firstName, lastName, username, password)
        createUser(firstName: firstName, lastName: lastName, username: username, password: password)
        //performSegue(withIdentifier: "loginSuccess", sender: self)
        ValidationModel.sessionIsOff = false
        if CartData.sharedInstance.count > 0
        {
            for item in CartData.sharedInstance
            {
                let cartItem = Cart(context: context)
                
                cartItem.username = username
                cartItem.frame = item.frame
                cartItem.itemImageURL = item.itemImageURL
                cartItem.itemName = item.itemName
                cartItem.itemNumber = item.itemNumber
                cartItem.itemPrice = item.itemPrice
                cartItem.itemTotal = item.itemTotal
                cartItem.quantity = item.quantity
                cartItem.size = item.size
                cartItem.status = "open"
                
                ad.saveContext()
            }
        }
        performSegue(withIdentifier: "toCheckout", sender: self)
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        signInView.isHidden = true
        signUpView.isHidden = false
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if attemptFetch(username: username, password: password)
        {
            ValidationModel.sessionIsOff = false
            ValidationModel.username = username
            
            if CartData.sharedInstance.count > 0
            {
                for item in CartData.sharedInstance
                {
                    let cartItem = Cart(context: context)
                    
                    cartItem.username = username
                    cartItem.frame = item.frame
                    cartItem.itemImageURL = item.itemImageURL
                    cartItem.itemName = item.itemName
                    cartItem.itemNumber = item.itemNumber
                    cartItem.itemPrice = item.itemPrice
                    cartItem.itemTotal = item.itemTotal
                    cartItem.quantity = item.quantity
                    cartItem.size = item.size
                    cartItem.status = "open"
                    
                    ad.saveContext()
                }
            }
            
            performSegue(withIdentifier: "toCheckout", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Invalid Credentials", message: "Credentials provided doesn't match our records", preferredStyle: .alert)
            
            let tryAgainAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
            
            let createAccountAction = UIAlertAction(title: "Create Account", style: .default){(action) in
                self.signInView.isHidden = true
                self.signUpView.isHidden = false
            }
            
            alert.addAction(tryAgainAction)
            alert.addAction(createAccountAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signInFromSignUpPageTapped(_ sender: UIButton) {
        signInView.isHidden = false
        signUpView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.isHidden = true
        signInView.isHidden = false

        firstNameLabel.isHidden = true
        lastNameLabel.isHidden = true
        emailAddressLabel.isHidden = true
        signupPasswordLabel.isHidden = true
        repeatPasswordLabel.isHidden = true
        
        
        validate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: - Delegate function to hide keyboard when tapped outside the field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        switch textField
        {
        case self.firstNameTextField:
            self.lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            eMailTextField.becomeFirstResponder()
        case eMailTextField:
            signupPasswordTextField.becomeFirstResponder()
        case signupPasswordTextField:
            repeatPasswordTextField.becomeFirstResponder()
        case repeatPasswordTextField:
            repeatPasswordTextField.resignFirstResponder()
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag
        {
        case 1:
            validateFirstName(firstName: firstNameTextField.text!)
            validate()
        case 2:
            validateLastName(lastName: lastNameTextField.text!)
            validate()
        case 3:
            validateEmail(email: eMailTextField.text!)
            validate()
        case 4:
            validateSignupPassword(password: signupPasswordTextField.text!)
            validate()
        case 5:
            comparePasswords(password: signupPasswordTextField.text!, repeatPassword:repeatPasswordTextField.text!)
            validate()
        default:
            break
        }
        
    }
    
    // MARK: - Unwind segues
    @IBAction func backToSignIn(_ segue:UIStoryboardSegue)
    {}
    
    // MARK: - User Defined Functions
    func createUser(firstName:String, lastName:String, username:String, password:String)
    {
        let user = User(context: context)
        user.firstName = firstName
        user.lastName = lastName
        user.username = username
        user.password = password
        
        ad.saveContext()
    }
    
    func attemptFetch(username:String, password:String) -> Bool
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            var usernameString = [String] ()
            var passwordString = [String] ()
            
            if results.count > 0{
                for items in results as! [NSManagedObject] {
                    if let user = items.value(forKey: "username") as? String {
                        //print(username)
                        usernameString.append(user)
                    }
                    
                    if let pass = items.value(forKey: "password") as? String {
                        //print(password)
                        passwordString.append(pass)
                    }

                }
            }
            print("Found \(results.count) users")
            
            
            for items in usernameString {
                print(items)
                if items == username
                {
                    if passwordString[usernameString.index(of: items)!] == password
                    {
                        
                            return true
                    }
                }
                print("\(username):\(items), \(password):\(passwordString[usernameString.index(of: items)!])")
            }
            
            for items in passwordString {
                print(items)
            }
            
        } catch  {
            print("Fetched Data Error!")
        }
        
        return false
    }
    
    func validate()
    {
        if ValidationModel.validationObject.signupFirstNameFlag && ValidationModel.validationObject.signUpLastNameFlag && ValidationModel.validationObject.signupEmailFlag && ValidationModel.validationObject.signupPasswordFlag && ValidationModel.validationObject.signupRepeatPasswordFlag
        {
            signUpButton.isEnabled = true
        }
        else{
            signUpButton.isEnabled = false
        }
    }
    
    func validateEmail(email: String)
    {
        if email == ""
        {
            emailAddressLabel.isHidden = false
            ValidationModel.validationObject.signupEmailFlag = false
        }
        else{
            let emailTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexEmail)
            let matchEmailId = emailTest.evaluate(with: email)
            if(!matchEmailId)
            {
                emailAddressLabel.isHidden = false
                ValidationModel.validationObject.signupEmailFlag = false
            }
            else
            {
                emailAddressLabel.isHidden = true
                ValidationModel.validationObject.signupEmailFlag = true
            }
        }
    }

    func validateFirstName(firstName: String)
    {
        if firstName == ""
        {
            firstNameLabel.isHidden = false
            ValidationModel.validationObject.signupFirstNameFlag = false
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexText)
            let matchName = nameTest.evaluate(with: firstName)
            if(!matchName)
            {
                firstNameLabel.isHidden = false
                ValidationModel.validationObject.signupFirstNameFlag = false
            }
            else{
                firstNameLabel.isHidden = true
                ValidationModel.validationObject.signupFirstNameFlag = true
            }
        }
    }
    
    func validateLastName(lastName: String)
    {
        if lastName == ""
        {
            lastNameLabel.isHidden = false
            ValidationModel.validationObject.signUpLastNameFlag = false
        }
        else{
            let nameTest = NSPredicate(format: "SELF MATCHES %@", ValidationModel.validationObject.regexText)
            let matchName = nameTest.evaluate(with: lastName)
            if(!matchName)
            {
                lastNameLabel.isHidden = false
                ValidationModel.validationObject.signUpLastNameFlag = false
            }
            else{
                lastNameLabel.isHidden = true
                ValidationModel.validationObject.signUpLastNameFlag = true
            }
        }
    }
    
    func validateSignupPassword(password: String)
    {
        if password == ""
        {
            signupPasswordLabel.isHidden = false
            ValidationModel.validationObject.signupPasswordFlag = false
        }
        else
        {
            signupPasswordLabel.isHidden = true
            ValidationModel.validationObject.signupPasswordFlag = true
        }
    }
    
    func comparePasswords(password: String, repeatPassword:String)
    {
        if password != repeatPassword
        {
            repeatPasswordLabel.isHidden = false
            ValidationModel.validationObject.signupRepeatPasswordFlag = false
        }
        else
        {
            repeatPasswordLabel.isHidden = true
            ValidationModel.validationObject.signupRepeatPasswordFlag = true
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
