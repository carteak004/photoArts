//
//  CartTableViewCell.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 06/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    var quantity = 0

    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    
    @IBAction func QuantityChanged(_ sender: UIStepper) {
        quantity = Int(sender.value)
        
        quantityLabel.text = "Quantity: \(quantity)"
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
