//
//  PullToRefreshVC.swift
//  TableView
//
//  Created by Engy on 11/2/24.
//

import UIKit

class PullToRefreshVC: UITableViewController {
    private var data: [String] = Array(repeating: "Item", count: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPullToRefresh()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50

    }

    func setupPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl =  refreshControl

    }

    @objc func refreshData() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var content  = cell.defaultContentConfiguration()
        content.text = data[indexPath.row]
        content.secondaryText = "Pull-to-Refresh Table View"

        cell.contentConfiguration = content
        return cell

    }


}
