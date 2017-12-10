//
//  HistoryViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 09/12/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var inactiveQueue:DispatchQueue!
    let queueX = DispatchQueue(label: "edu.cs.niu.queueX")
    
    var sessionCart = [CartData]()
    

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        if !ValidationModel.sessionIsOff
        {
            sessionCart.removeAll()
            fetchCart()
            if sessionCart.count > 0
            {
                historyTableView.isHidden = false
                emptyLabel.isHidden = true
            }
            else
            {
                historyTableView.isHidden = true
                emptyLabel.isHidden = false
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let queue = inactiveQueue
        {
            queue.activate()
        }
        
        if !ValidationModel.sessionIsOff
        {
            sessionCart.removeAll()
            fetchCart()
            if sessionCart.count > 0
            {
                historyTableView.isHidden = false
                emptyLabel.isHidden = true
            }
            else
            {
                historyTableView.isHidden = true
                emptyLabel.isHidden = false
            }
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
        return sessionCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! HistoryTableViewCell
        
        
        let cartItem = sessionCart[indexPath.row]
        
        queueX.sync {
            cell.thumbImageView.image = cartItem.itemImageURL.loadImage()
        }
        cell.nameLabel.text = cartItem.itemName
        cell.frameLabel.text = "Frame: \(cartItem.frame!)"
        cell.sizeLabel.text = "Size: \(cartItem.size!)"
        cell.priceLabel.text = "Price: $\(cartItem.itemPrice!).00"
        
        return cell
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
                    if items.value(forKey: "username") as? String == ValidationModel.username && items.value(forKey: "status") as? String == "complete"{
                        sessionCart.append(CartData(quantity: (items.value(forKey: "quantity") as? Int64)!, size: (items.value(forKey: "size") as? String)!, frame: (items.value(forKey: "frame") as? String)!, itemPrice: (items.value(forKey: "itemPrice") as? Int64)!, itemTotal: (items.value(forKey: "itemTotal") as? Int64)!, itemNumber: (items.value(forKey: "itemNumber") as? String)!, itemName: (items.value(forKey: "itemName") as? String)!, itemImageURL: (items.value(forKey: "itemImageURL") as? String)!))
                        //print(items.value(forKey: "itemName")!)
                    }
                }
            }
            print("Found \(sessionCart.count) items in the cart hist")
        } catch  {
            print("Fetched Data Error!")
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
