//
//  ItemViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 30/10/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/*implementation of picker view is adopted from https://makeapppie.com/2014/09/18/swift-swift-implementing-picker-views/ */
import UIKit

class ItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sentLargeImage:String!
    let frameComponent = 0
    let sizeComponent = 1
    
    let pickerData = [["No Frame","Matte Black","Matte White", "Brushed Silver", "Matte Brass", "Light Grey Wood"],["7\" x 5\"", "10\" x 8\"", "14\" x 11\"", "20\" x 16\"", "24\" x 18\"", "40\" x 30\"", "54\" x 40\"", "60\" x 44\""]]
    let price = [[24,35,50,76,97,164,230,248],[29,46,89,158,189,365,570,0]]
    
    var quantity = 1
    var size:String!
    var frame:String!
    var itemPrice:Int!
    var itemTotal:Int!
    
    var inactiveQueue:DispatchQueue!

    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepperLabel: UIStepper!
    @IBOutlet weak var addToCartButtonLabel: UIBarButtonItem!
    
    @IBAction func quantityStepper(_ sender: UIStepper) {
        quantity = Int(sender.value)
        quantityLabel.text = quantity.description
        updateLabel()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeImageView.image = sentLargeImage.loadImage()   //load image in image view
        
        //pickerView.selectRow(0, inComponent: frameComponent, animated: false) //select the No frame component
        updateLabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Picker view Data source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    //MARK: Picker view Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    
    
    //MARK: User defined functions
    func updateLabel()
    {
        let frameRow = pickerView.selectedRow(inComponent: frameComponent)
        let sizeRow = pickerView.selectedRow(inComponent: sizeComponent)
        
        frame = pickerData[frameComponent][frameRow]
        size = pickerData[sizeComponent][sizeRow]
        
        frameLabel.text = frame
        sizeLabel.text = size
        
        quantityStepperLabel.isEnabled = true
        quantityStepperLabel.tintColor = UIColor.blue
        quantityLabel.textColor = UIColor.black
        addToCartButtonLabel.isEnabled = true
        addToCartButtonLabel.tintColor = UIColor.blue
        
        if frameRow == 0
        {
            itemPrice = price[0][sizeRow]
            itemTotal = itemPrice*quantity
            priceLabel.text = "$\(itemTotal!).00"
            
        }
        else
        {
            itemPrice = price[1][sizeRow]
            itemTotal = itemPrice*quantity
            

            if itemPrice == 0
            {
                priceLabel.text = "Not Available"
                quantityStepperLabel.isEnabled = false
                quantityStepperLabel.tintColor = UIColor.gray
                quantityLabel.textColor = UIColor.gray
                addToCartButtonLabel.isEnabled = false
                addToCartButtonLabel.tintColor = UIColor.gray
                
            }
            else
            {
                priceLabel.text = "$\(itemTotal!).00"
            }
        }
        
        //update color of photo background
        
        switch frameRow {
        case 0:
            viewForImage.backgroundColor = UIColor.white
            break
        case 1:
            viewForImage.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
            break
        case 2:
            viewForImage.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.94, alpha:1.0)
            break
        case 3:
            viewForImage.backgroundColor = UIColor(red:0.73, green:0.73, blue:0.75, alpha:1.0)
            break
        case 4:
            viewForImage.backgroundColor = UIColor(red:0.67, green:0.59, blue:0.31, alpha:1.0)
            break
        case 5:
            viewForImage.backgroundColor = UIColor(red:0.59, green:0.58, blue:0.57, alpha:1.0)
            break
        default:
            viewForImage.backgroundColor = UIColor.white
            break
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
