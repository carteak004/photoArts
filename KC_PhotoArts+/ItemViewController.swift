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
    var flag = false
    var frame = false
    
    let frameComponent = 0
    let sizeComponent = 1
    
    let pickerData = [["No Frame","Matte Black","Matte White", "Brushed Silver", "Matte Brass", "Light Grey Wood"],["7\" x 5\"", "10\" x 8\"", "14\" x 11\"", "20\" x 16\"", "24\" x 18\"", "40\" x 30\"", "54\" x 40\"", "60\" x 44\""]]
    let price = [["$24.00","$35.00","$50.00","$76.00","$97.00","$164.00","$230.00","$248.00"],["$29.00","$46.00","$89.00","$158.00","$189.00","$365.00","$570.00","Not Available"]]

    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func addToCartButtonPressed(_ sender: UIBarButtonItem) {
        let alertcontroller = UIAlertController(title: "Success", message: "\(title!) added successfully to your cart!!!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertcontroller.addAction(okAction)
        
        self.present(alertcontroller, animated: true, completion: nil)
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
        
        let frame = pickerData[frameComponent][frameRow]
        let size = pickerData[sizeComponent][sizeRow]
        frameLabel.text = frame
        sizeLabel.text = size
        if frameRow == 0
        {
            priceLabel.text = price[0][sizeRow]
        }
        else
        {
            priceLabel.text = price[1][sizeRow]
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
