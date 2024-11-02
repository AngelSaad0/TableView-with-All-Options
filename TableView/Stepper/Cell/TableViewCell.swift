//
//  TableViewCell.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    var price: Double = 0.0



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        quantityLabel.text = String(Int(sender.value))
        priceLabel.text = "Total: $\(String(format: "%.2f", price * Double(sender.value)))"

    }

    func configCell(_ item:ShoppingCartItem1) {
        price = item.pricePerUnit
        titleLabel.text = "\(item.name) - $\(item.pricePerUnit) each"
        priceLabel.text = "Total: $\(String(format: "%.2f", item.pricePerUnit * Double(item.quantity)))"
        quantityLabel.text = "\(item.quantity)"
        stepper.value = Double(item.quantity)
        stepper.minimumValue = 1
        stepper.maximumValue = 8
        stepper.stepValue = 1

    }

}

