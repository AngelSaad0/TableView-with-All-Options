//
//  TableWithDeleteRowsTrailingSwipe.swift
//  TableView
//
//  Created by Engy on 11/2/24.
//
// Leading And Trailing Swipe
import UIKit

class TableWithLeadingAndTrailingSwipe: UIViewController {

    var data =
    ["Rabbit","Cat", "Horse", "Dog", "Monkey"]

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension TableWithLeadingAndTrailingSwipe: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let insertAtTop = UIContextualAction(style: .normal, title: "insertAtTop") { (action, view, completionHandler) in
            let dataForCell = self.data[indexPath.row]
            self.data.insert(dataForCell, at: 0)
            tableView.reloadData()
            completionHandler(true)
        }

        let appendAtBottom = UIContextualAction(style: .normal, title: "appendAtBottom") { (action, view, completionHandler) in
            let dataForCell = self.data[indexPath.row]
            self.data.append(dataForCell)
            tableView.reloadData()
            completionHandler(true)
        }

        insertAtTop.backgroundColor = .green
        appendAtBottom.backgroundColor = .purple

        let configuration = UISwipeActionsConfiguration(actions: [insertAtTop, appendAtBottom])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],with: .bottom)
            completionHandler(true)
        }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            print("edit")
            completionHandler(true)
        }

        editAction.backgroundColor = .purple

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }


}
