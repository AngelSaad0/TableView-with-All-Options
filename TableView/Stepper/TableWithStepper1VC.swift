//
//  TableWithStepper1VC.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//

struct ShoppingCartItem1 {
    let name: String
    let pricePerUnit: Double
    var quantity: Int
}
import UIKit

class TableWithStepper1VC: UIViewController {

    @IBOutlet var tableView: UITableView!
    var items: [ShoppingCartItem1] = [
        ShoppingCartItem1(name: "Apple", pricePerUnit: 0.99, quantity: 1),
        ShoppingCartItem1(name: "Banana", pricePerUnit: 0.59, quantity: 1),
        ShoppingCartItem1(name: "Orange", pricePerUnit: 0.79, quantity: 1)
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }

}
extension TableWithStepper1VC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.configCell(item)
        return cell
    }
   


}
