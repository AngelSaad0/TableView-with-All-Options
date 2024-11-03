//
//  TableWithContextMenuInteraction.swift
//  TableView
//
//  Created by Engy on 11/2/24.
//

import UIKit

class TableWithContextMenuInteraction: UIViewController {
    @IBOutlet var tableView: UITableView!
    let items = ["Swift", "SwiftUI", "Objective"]
    var editableItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        editableItems = items
    }
}

extension TableWithContextMenuInteraction: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editableItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")

        cell.textLabel?.text = editableItems[indexPath.row]

        // Add context menu interaction
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
        return cell
    }
}

extension TableWithContextMenuInteraction: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let pointInTableView = tableView.convert(location, from: interaction.view)
            guard let indexPath = tableView.indexPathForRow(at: pointInTableView) else {
                print("Index path not found for location: \(pointInTableView)")
                return nil
            }
        let item = editableItems[indexPath.row]
        let action1 = UIAction(title: "Edit \(item)") { _ in
            self.editItem(at: indexPath)
        }
        let action2 = UIAction(title: "Delete \(item)") { _ in
            self.deleteItem(at: indexPath)
        }
        let action3 = UIAction(title: "Move \(item) At Top") { _ in
            self.moveItem(at: indexPath)
        }
        let action4 = UIAction(title: "Copy \(item)") { _ in
            self.copyItem(item)
        }
        let configuration = UIContextMenuConfiguration(actionProvider:  { _ in
            return UIMenu(children: [action1,action2,action3,action4])
        })
        return configuration

    }


        // MARK: - Action Implementations

    private func editItem(at indexPath: IndexPath) {
        let item = editableItems[indexPath.row]
        // Present an alert for editing
        let alertController = UIAlertController(title: "Edit Item", message: "Edit your item:", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = item
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alertController.textFields?.first?.text, !text.isEmpty {
                self.editableItems[indexPath.row] = text
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        }
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)

    }
    private func deleteItem(at indexPath: IndexPath) {
        editableItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)

    }
    private func moveItem(at indexPath: IndexPath) {
        if indexPath.row > 0 {
            let itemToMove = editableItems.remove(at: indexPath.row)
            editableItems.insert(itemToMove, at: 0)
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))

        }
    }
        private func copyItem(_ item: String) {
            UIPasteboard.general.string = item
            let alert = UIAlertController(title: "Copied", message: "\(item) has been copied to clipboard.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}
