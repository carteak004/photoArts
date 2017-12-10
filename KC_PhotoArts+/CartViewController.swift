//
//  CartViewController.swift
//  KC_PhotoArts+
//
//  Created by ta on 11/6/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 The view implementing this class will show the items added to 
 cart in a table view and displays the total value of the cart. 
 This also shows a button to checkout.
 **************************************************************/

import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, cartCellDelegate {

    //var totalPrice = 0
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkOutButtonLabel: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var inactiveQueue:DispatchQueue!
    let queueX = DispatchQueue(label: "edu.cs.niu.queueX")
    
    var sessionCart = [CartData]()
    
    @IBAction func checkOutButtonPressed(_ sender: UIButton) {
        
        
        if ValidationModel.sessionIsOff
        {
            
            let alertController = UIAlertController(title: "How do you want to Proceed?", message: "Sign in to track your Purchase History", preferredStyle: .actionSheet)
            
            let signInAction = UIAlertAction(title: "Sign In", style: .default) { (action) in
                self.performSegue(withIdentifier: "login", sender: self)
            }
            
            let guestAction = UIAlertAction(title: "Check out as Guest", style: .default) { (action) in
                self.performSegue(withIdentifier: "checkOut", sender: self)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(signInAction)
            alertController.addAction(guestAction)
            alertController.addAction(cancel)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            self.performSegue(withIdentifier: "checkOut", sender: self)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if !ValidationModel.sessionIsOff
        {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Purchase History", style: .plain, target: self, action: #selector(showHistory))
            fetchCart()
            CartData.sharedInstance = sessionCart
        }
        else{
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
        checkOutViewUpdate()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let queue = inactiveQueue
        {
            queue.activate()
        }

        if !ValidationModel.sessionIsOff
        {
            fetchCart()
            CartData.sharedInstance = sessionCart
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view source and delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if !ValidationModel.sessionIsOff
        {
            print(sessionCart.count)
            return sessionCart.count
        }*/
        
        return CartData.sharedInstance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! CartTableViewCell
        
        cell.delegate = self
        let cartItem =  CartData.sharedInstance[indexPath.row]
        /*let cartItem:CartData!
        
        if !ValidationModel.sessionIsOff
        {
            cartItem = sessionCart[indexPath.row]
        }
        else{
             cartItem =  CartData.sharedInstance[indexPath.row]
        }*/
        
        queueX.sync {
            cell.artImageView.image = cartItem.itemImageURL.loadImage()
        }
        cell.nameLabel.text = cartItem.itemName
        cell.frameLabel.text = "Frame: \(cartItem.frame!)"
        cell.sizeLabel.text = "Size: \(cartItem.size!)"
        cell.priceLabel.text = "Price: $\(cartItem.itemPrice!).00"
        cell.quantityLabel.text = "Quantity: \(cartItem.quantity!)"
        cell.itemTotalLabel.text = "$\(cartItem.itemTotal!)"
        
        cell.quantityStepper.value = Double(cartItem.quantity)
        
        cell.index = indexPath.row
        
        return cell
    }
    
    /*swipe left to delete feature. adopted from https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {/*
            var cartItem = [CartData]()
            
            if !ValidationModel.sessionIsOff
            {
                cartItem = sessionCart
                print(sessionCart.count)
            }
            else{
                cartItem =  CartData.sharedInstance
            }
         
            if !ValidationModel.sessionIsOff
            {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
                request.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(request)
                    
                    if results.count > 0{
                        for items in results as! [NSManagedObject] {
                            if items.value(forKey: "username") as? String == ValidationModel.username && items.value(forKey: "status") as? String == "open" && items.value(forKey: "itemName") as? String == cartItem[indexPath.row].itemName{
                                cartItem.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .fade)
                                context.delete(items)
                                ad.saveContext()
                                //tableView.deleteRows(at: [indexPath], with: .fade)
                            }
                        }
                    }
                    print("Found \(results.count) items in the cart delete")
                } catch  {
                    print("Fetched Data Error!")
                }
            }
            else{
            print(cartItem.count)
                cartItem.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            print(cartItem.count)
            }*/
            
            CartData.sharedInstance.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        checkOutViewUpdate()
        //print(CartData.sharedInstance.count)
    }
    
    
    // MARK - User defined functions
    
    //purchase histroy button
    func showHistory(){
        performSegue(withIdentifier: "history", sender: self)
    }
    
    //logout button action
    func logoutAction()
    {
        ValidationModel.username = ""
        ValidationModel.sessionIsOff = true
        CartData.sharedInstance.removeAll()
        checkOutViewUpdate()
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        //cartTableView.reloadData()
    }
    
    //delegate function
    func updateTotalforaCell(name:String, quantity:Int64)
    {
        /*
        if !ValidationModel.sessionIsOff
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(request)
                
                if results.count > 0{
                    for items in results as! [NSManagedObject] {
                        if items.value(forKey: "username") as? String == ValidationModel.username && items.value(forKey: "status") as? String == "open" && items.value(forKey: "itemName") as? String == name{
                            items.setValue(quantity, forKey: "quantity")
                            ad.saveContext()
                        }
                    }
                }
                print("Found \(results.count) items in the cart update")
            } catch  {
                print("Fetched Data Error!")
            }
        }*/

        updateTotalPrice()
    }
    
    //fetch data
    func fetchCart()
    {
        sessionCart.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0{
                for items in results as! [NSManagedObject] {
                    if items.value(forKey: "username") as? String == ValidationModel.username && items.value(forKey: "status") as? String == "open"{
                        sessionCart.append(CartData(quantity: (items.value(forKey: "quantity") as? Int64)!, size: (items.value(forKey: "size") as? String)!, frame: (items.value(forKey: "frame") as? String)!, itemPrice: (items.value(forKey: "itemPrice") as? Int64)!, itemTotal: (items.value(forKey: "itemTotal") as? Int64)!, itemNumber: (items.value(forKey: "itemNumber") as? String)!, itemName: (items.value(forKey: "itemName") as? String)!, itemImageURL: (items.value(forKey: "itemImageURL") as? String)!))
                        //print(items.value(forKey: "itemName")!)
                    }
                }
            }
            print("Found \(sessionCart.count) items in the cart")
        } catch  {
            print("Fetched Data Error!")
        }

    }
    
    //function to update check out view. If there are no items in the cart, it will hide the controls on the screen or else it will display everything.
    
    func checkOutViewUpdate()
    {
        /*var cartSource = [CartData]()
        
        if !ValidationModel.sessionIsOff
        {
            cartSource = sessionCart
        }
        else
        {
            cartSource = CartData.sharedInstance
        }*/
        
        if CartData.sharedInstance.count == 0
        {
            cartTableView.isHidden = true
            emptyLabel.isHidden = false
            checkOutButtonLabel.isHidden = true
            totalPriceLabel.isHidden = true
            priceLabel.isHidden = true
            //print("empty")
        }
        else{
            cartTableView.isHidden = false
            emptyLabel.isHidden = true
            checkOutButtonLabel.isHidden = false
            totalPriceLabel.isHidden = false
            priceLabel.isHidden = false
            // print("not empty")
        }
        //print(CartData.sharedInstance.count)
        cartTableView.reloadData()
        
        updateTotalPrice()
    }
    
    func updateTotalPrice()
    {
        CartData.totalPrice = 0
        
       /* var cartSource = [CartData]()
        
        if !ValidationModel.sessionIsOff
        {
            cartSource = sessionCart
        }
        else
        {
            cartSource = CartData.sharedInstance
        }
        */
        for item in CartData.sharedInstance
        {
            CartData.totalPrice += item.itemTotal
        }
        totalPriceLabel.text = "$\(CartData.totalPrice).00"
    }
    
    
    // MARK - Unwind segue
    @IBAction func unwindToCancel(_ segue:UIStoryboardSegue)
    {
        CartData.totalPrice = 0
    }
    
    @IBAction func unwindFromLogin(_ segue:UIStoryboardSegue)
    {}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkOut"
        {
            let navVc = segue.destination as! UINavigationController
            let checkOutVC = navVc.topViewController as! CheckoutViewController
            let checkOutVC = segue.destination as! CheckoutViewController
            
            checkOutVC.sentSubTotal = Double(totalPrice)
        }
 
        
    }
    */

}
