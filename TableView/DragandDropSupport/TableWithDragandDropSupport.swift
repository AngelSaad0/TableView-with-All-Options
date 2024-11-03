//
//  TableWithDragandDropSupport.swift
//  TableView
//
//  Created by Engy on 11/3/24.
//

import UIKit

class TableWithDragandDropSupport: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {

    @IBOutlet weak var tableView: UITableView!

    var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDragDelegate
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = items[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }

    // MARK: - UITableViewDropDelegate
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move)
        }
        return UITableViewDropProposal(operation: .copy)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }

        for item in coordinator.items {
            let sourceIndexPath = item.sourceIndexPath

            if let sourceIndexPath = sourceIndexPath,
               let dataItem = item.dragItem.localObject as? String {
                // Update your data source
                items.remove(at: sourceIndexPath.row)
                items.insert(dataItem, at: destinationIndexPath.row)

                // Move the row in the table view
                tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
            }
        }
    }

    // Optional: Visual feedback during dragging
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        tableView.alpha = 0.5
    }

    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        tableView.alpha = 1.0
    }
}
