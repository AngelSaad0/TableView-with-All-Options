//
//  TableViewWithSearchBar.swift
//  TableView
//
//  Created by Engy on 11/2/24.
//

import UIKit

class TableViewWithSearchBar: UIViewController {

    var data =
    ["Rabbit","Cat", "Horse", "Dog", "Monkey", "Rabbit", "Cat", "Horse", "Dog", "Monkey", "Rabbit","Cat" ,"AirConditioner", "Television", "Heater", "WashingMachine", "Computer", "Tomato", "Potato" ,"Onions", "Chillies", "Carrot", "Tomato", "Potato", "Onions", "Chillies", "Rabbit","Cat", "Horse", "Dog", "Monkey", "Rabbit","Cat", "Horse", "Dog", "Monkey", "Rabbit","Cat", "AirConditioner ","Television", "Heater", "WashingMachine", "Computer", "Tomato", "Potato", "Onions", "Chillies" ,"Carrot", "Tomato", "Potato", "Onions", "Chillies"]
    var searchWords:[String] = []
    var isSearching = false


    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension TableViewWithSearchBar: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if isSearching {
           return searchWords.count
        } else {
            return data.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        if isSearching {
            cell.textLabel?.text = searchWords[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        return cell
    }

}
extension TableViewWithSearchBar:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWords = data.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
