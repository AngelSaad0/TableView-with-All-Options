//
//  TableWithMultiSelection.swift
//  TableView
//
//  Created by Engy on 11/3/24.
//

import UIKit

class TableWithMultiSelection: UIViewController {
    let items = ["Swift", "SwiftUI", "Objective"]
    var editableItems: [String] = []
    var selectedIndexPaths:IndexSet = []
    var isClicked = false


    @IBOutlet var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        editableItems = items
        tableView.allowsMultipleSelection = true


    }

    @IBAction func deleteButtonClicked(_ sender: Any) {
        guard !selectedIndexPaths.isEmpty else { return }
        let itemsToDelete = selectedIndexPaths.map {$0}.sorted(by: >)
        for item in itemsToDelete {
            editableItems.remove(at: item)
        }
        selectedIndexPaths.removeAll()
        tableView.reloadData()

        isClicked.toggle()
        tableView.isEditing = isClicked

    }
    

}
extension TableWithMultiSelection: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = editableItems[indexPath.row]
        if selectedIndexPaths.contains(indexPath.row) {
            cell.contentView.backgroundColor = .lightGray
            cell.accessoryType = .checkmark

        } else {
            cell.contentView.backgroundColor = .white
            cell.accessoryType = .none
        }
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath.row) {
            selectedIndexPaths.remove(indexPath.row)
            tableView.cellForRow(at: indexPath)?.isSelected = false

        } else {
            selectedIndexPaths.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .none)

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndexPaths.remove(indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)

    }


}
