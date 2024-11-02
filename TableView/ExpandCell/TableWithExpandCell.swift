//
//  TableWithExpandCell.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//

import UIKit

class TableWithExpandCell: UITableViewController {
    var expandedcell:IndexSet = []

    var names = ["Anish", "Ashok", "Chaitanya","Akash"]


    var text = ["Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design and produces software that runs lightning-fast.",
                "Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design and produces software that runs lightning-fast.",
                "Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design and produces software that runs lightning-fast.","Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design and produces software that runs lightning-fast."
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 124
        tableView.register(UINib(nibName: "ExpandTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandTableViewCell")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return text.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandTableViewCell", for: indexPath) as? ExpandTableViewCell else {return UITableViewCell()}
        // Configure the cell's labels
        cell.textLbl.text = text[indexPath.row]
        cell.nameLbl.text = names[indexPath.row]

        // Configure the expansion state
        configureCellExpansion(cell,for: indexPath)

        // Set the button action
        cell.butttonClicked = {
            self.toggleCellExpansion(at: indexPath)
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        return cell
    }

    private func configureCellExpansion(_ cell: ExpandTableViewCell, for indexPath: IndexPath) {
        if expandedcell.contains(indexPath.row) {
            cell.textLbl.numberOfLines = 0
            cell.moreBtn.setTitle("See Less", for: .normal)
        } else {
            cell.textLbl.numberOfLines = 3
//            cell.moreBtn.setTitle("See More", for: .normal)
        }
    }

    // Helper method to toggle cell expansion
    private func toggleCellExpansion(at indexPath: IndexPath) {
        if expandedcell.contains(indexPath.row) {
            expandedcell.remove(indexPath.row)
        } else {
            expandedcell.insert(indexPath.row)
        }
    }
}
