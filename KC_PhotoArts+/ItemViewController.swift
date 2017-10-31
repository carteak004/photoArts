//
//  ItemViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 30/10/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sentLargeImage:String!
    var flag = false
    var frame = false
    
    let Frame = ["No Frame","Matte Black","Matte White", "Brushed Silver", "Matte Brass", "Light Grey Wood"]
    let sizeWithOutFrame = ["7” x 5” = $24.00", "10” x 8” = $35.00", "14” x 11” = $50.00", "20” x 16” = $76.00", "24” x 18” = $97.00", "40” x 30” = $164.00", "54” x 40” = $230.00", "60” x 44” = $248.00"]
    
    let sizeWithFrame = ["7” x 5” = $29.00", "10” x 8” = $46.00", "14” x 11” = $89.00", "20” x 16” = $158.00", "24” x 18” = $189.00", "40” x 30” = $365.00", "54” x 40” = $570.00"]

    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var frameButtonLabel: UIButton!
    @IBOutlet weak var sizeButtonLabel: UIButton!
    
    
    @IBAction func frameButton(_ sender: UIButton) {
        flag = false
        pickerView.isHidden = false
        
        let selected = Frame[pickerView.selectedRow(inComponent: 0)]
        
        frameButtonLabel.titleLabel?.text = selected
        
        if frameButtonLabel.titleLabel?.text == "No Frame"
        {
            frame = false
        }
        else{
            frame = true
            sizeButtonLabel.titleLabel?.text = "7” x 5” = $29.00"
        }
    }
    
    @IBAction func sizeButton(_ sender: UIButton) {
        flag = true
        pickerView.isHidden = false
        
        let selected:String!
        
        if frame
        {
            selected = sizeWithFrame[pickerView.selectedRow(inComponent: 0)]
        }
        else{
            selected = sizeWithOutFrame[pickerView.selectedRow(inComponent: 0)]
        }
        
        
        sizeButtonLabel.titleLabel?.text = selected
    }
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.isHidden = true
        frameButtonLabel.titleLabel?.text = "No Frame"
        sizeButtonLabel.titleLabel?.text = "7” x 5” = $24.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Picker view Data source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if !flag
        {
            return Frame.count
        }
        else if flag && frame
        {
            return sizeWithFrame.count
        }
        else{
            return sizeWithOutFrame.count
        }
    }
    
    //MARK: Picker view Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if !flag
        {
            return Frame[row]
        }
        else if flag && frame
        {
            return sizeWithFrame[row]
        }
        else{
            return sizeWithOutFrame[row]
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
