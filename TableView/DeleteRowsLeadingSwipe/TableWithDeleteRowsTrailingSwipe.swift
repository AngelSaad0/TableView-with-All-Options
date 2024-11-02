//
//  TableWithDeleteRowsTrailingSwipe.swift
//  TableView
//
//  Created by Engy on 11/2/24.
//

import UIKit

class TableWithDeleteRowsTrailingSwipe: UIViewController {

    var data =
    ["Rabbit","Cat", "Horse", "Dog", "Monkey", "Rabbit", "Cat", "Horse", "Dog", "Monkey", "Rabbit","Cat" ,"AirConditioner", "Television", "Heater", "WashingMachine", "Computer", "Tomato", "Potato" ,"Onions", "Chillies", "Carrot", "Tomato", "Potato", "Onions", "Chillies", "Rabbit","Cat", "Horse", "Dog", "Monkey", "Rabbit","Cat", "Horse", "Dog", "Monkey", "Rabbit","Cat", "AirConditioner ","Television", "Heater", "WashingMachine", "Computer", "Tomato", "Potato", "Onions", "Chillies" ,"Carrot", "Tomato", "Potato", "Onions", "Chillies"]

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension TableWithDeleteRowsTrailingSwipe: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with:.fade)
    }

}
