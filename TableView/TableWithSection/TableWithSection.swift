//
//  TableWithSection.swift
//  TableView
//
//  Created by Engy on 11/2/24.
//

import UIKit

// Data structure for table sections
struct TableData {
    var sectionType: String
    var sectionFooter: String
    var sectionNames: [String]
}

class TableWithSection: UITableViewController {

    // Sample data for table view
    var data = [
        TableData(sectionType: "Animals", sectionFooter: "List of common animals.", sectionNames: ["Rabbit", "Cat", "Horse", "Dog", "Monkey"]),
        TableData(sectionType: "Electronics", sectionFooter: "Various electronic devices.", sectionNames: ["AirConditioner", "Television", "Heater", "WashingMachine", "Computer"]),
        TableData(sectionType: "Vegetables", sectionFooter: "Healthy vegetables to eat.", sectionNames: ["Tomato", "Potato", "Onions", "Chillies", "Carrot"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDataSource Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].sectionNames.count
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return data[section].sectionFooter
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.section].sectionNames[indexPath.row]
        cell.accessoryType = .detailDisclosureButton
        return cell
    }

    // Custom header view with button
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let headerLabel = UILabel()
        headerLabel.text = data[section].sectionType
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton(type: .system)
        button.setTitle("Move cell", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = section // Set the tag to identify the section
        button.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)

        headerView.addSubview(headerLabel)
        headerView.addSubview(button)

        // Constraints for label and button
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }

    // Button action
    @objc func headerButtonTapped(_ sender: UIButton) {
        tableView.isEditing = true
        let section = sender.tag
        print("Button tapped in section \(section)")
        // You can perform any action based on the section here
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 2
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data[indexPath.section].sectionNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = data[sourceIndexPath.section].sectionNames[sourceIndexPath.row]
        data[sourceIndexPath.section].sectionNames.remove(at: sourceIndexPath.row)
        data[destinationIndexPath.section].sectionNames.insert(movedItem, at: destinationIndexPath.row)
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate Methods

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .lightText
        case 1:
            cell.backgroundColor = .secondaryLabel
        default:
            cell.backgroundColor = .tertiaryLabel
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .cyan
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // Adjust height as needed
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("detailDisclosureButton")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

   
}
