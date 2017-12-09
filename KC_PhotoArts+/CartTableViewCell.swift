//
//  CartTableViewCell.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 06/11/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/**************************************************************
 class to hold outlets of the cart view cell.
 **************************************************************/
import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var itemTotalLabel: UILabel!
    
    weak var delegate:cartCellDelegate?
    
    var index:Int!
    
    @IBAction func QuantityChanged(_ sender: UIStepper) {
        CartData.sharedInstance[index].quantity = Int64(sender.value)
        
        CartData.sharedInstance[index].itemTotal = CartData.sharedInstance[index].itemPrice * CartData.sharedInstance[index].quantity
        
        quantityLabel.text = "Quantity: \(CartData.sharedInstance[index].quantity!)"
        itemTotalLabel.text = "$\(CartData.sharedInstance[index].itemTotal!)"
        
        delegate?.updateTotalforaCell()
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

protocol cartCellDelegate: class {
    func updateTotalforaCell()
}
