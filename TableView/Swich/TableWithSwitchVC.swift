//
//  TableWithSwitchVC.swift
//  TableView
//
//  Created by Engy on 10/30/24.
//

import UIKit
struct SettingItem {
    var name: String
    var isOn: Bool
}

class TableWithSwitchVC: UIViewController {

    @IBOutlet var tableView1: UITableView!
    var item: [SettingItem] = [
        SettingItem(name: "Notifications", isOn: true),
        SettingItem(name: "Location Access", isOn: true),
        SettingItem(name: "Auto-Update", isOn: false),
        SettingItem(name: "Dark Mode", isOn: false),

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        checkState()
        setupTableView()
    }

    func setupTableView(){
        tableView1.delegate = self
        tableView1.dataSource = self
    }


    func checkState(){
        for (index,_) in item.enumerated() {
            if let state  = UserDefaults.standard.object(forKey: "\(index)") as? Bool {
                item[index].isOn = state
            }
        }
    }
}

extension TableWithSwitchVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        //swich
        let swichView  = UISwitch(frame: .zero)
        swichView.setOn(item[indexPath.row].isOn, animated: true)
        swichView.tag = indexPath.row
        swichView.addTarget(self, action: #selector(swichChanged(_ : )), for: .valueChanged)
        //content
        var content = cell.defaultContentConfiguration()
        content.text = item[indexPath.row].name


        //cell setup
        cell.contentConfiguration = content
        cell.accessoryView = swichView
        return cell
    }

    @objc func swichChanged(_ sender: UISwitch) {
        print(sender.tag)
    }

}

