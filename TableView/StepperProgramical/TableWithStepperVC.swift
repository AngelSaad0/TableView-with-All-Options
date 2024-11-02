//
//  TableWithStepperVC.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//


struct ShoppingCartItem {
    let name: String
    let pricePerUnit: Double
    var quantity: Int
}
import UIKit

class TableWithStepperVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    var items: [ShoppingCartItem] = [
        ShoppingCartItem(name: "Apple", pricePerUnit: 0.99, quantity: 1),
        ShoppingCartItem(name: "Banana", pricePerUnit: 0.59, quantity: 1),
        ShoppingCartItem(name: "Orange", pricePerUnit: 0.79, quantity: 1)
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension TableWithStepperVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        // Create a UILabel to display the quantity
        let quantityLabel = UILabel()
        quantityLabel.text = String(item.quantity)
        quantityLabel.font = UIFont.systemFont(ofSize: 16)

        // Create a UIStepper for quantity adjustment
        let stepper = UIStepper()
        stepper.maximumValue = 0
        stepper.maximumValue = 6
//        stepper.stepValue = 1
        stepper.value = Double(item.quantity)
        stepper.tag = indexPath.row
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)

        // Stack View for Label and Stepper
        let stackView = UIStackView(arrangedSubviews: [quantityLabel,stepper])
        stackView.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center

        // Configure the cell content
        var content  = cell.defaultContentConfiguration()
        content.text =  "\(item.name) - $\(item.pricePerUnit) each"
        content.secondaryText = "Total: $\(String(format: "%.2f", item.pricePerUnit * Double(item.quantity)))"

        // Set up the cell with the content and stack view
        cell.contentConfiguration = content
        cell.accessoryView = stackView
        return cell
    }

    @objc func stepperValueChanged(_ sender:UIStepper) {
        let index = sender.tag
        items[index].quantity = Int(sender.value)
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) {
            let item = items[index]

            var updatedContent = cell.defaultContentConfiguration()
            updatedContent.text = "\(item.name) - $\(item.pricePerUnit) each"
            updatedContent.secondaryText = "Total: $\(String(format: "%.2f", item.pricePerUnit * Double(item.quantity)))"

            if let stackView = cell.accessoryView as? UIStackView {
                if let quantityLabel = stackView.arrangedSubviews.first as? UILabel {
                    quantityLabel.text = String(format: "%0.0f", sender.value)
                }
            }
            cell.contentConfiguration = updatedContent
        }
    }
}
