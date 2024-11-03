//
//  TableWithPaginationAndInfiniteScrolling.swift
//  TableView
//
//  Created by Engy on 11/3/24.
//

import UIKit

class TableWithPaginationAndInfiniteScrolling: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var items: [String] = []
    var isLoading = false
    var currentPage = 1
    let itemsPerPage = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMoreData()
    }

    // MARK: - Load Data
    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true

        // Show loading indicator
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.center = tableView.center
        tableView.tableFooterView = spinner
        spinner.startAnimating()

        // Simulating a network delay
        DispatchQueue.global().async {
            sleep(1) // Simulate network delay
            //1...20
            //21 + 40
            let newItems = ((self.currentPage - 1) * self.itemsPerPage + 1)...self.currentPage * self.itemsPerPage
            let newItemsArray = newItems.map { "Item \($0)" }

            DispatchQueue.main.async {
                    self.items.append(contentsOf: newItemsArray)
                    self.currentPage += 1
                    self.tableView.reloadData()
                    self.isLoading = false
                    // Hide loading indicator
                    self.tableView.tableFooterView = nil
            }
        }
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

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Check if we are at the last item and load more data
        if indexPath.row == items.count - 1 && currentPage < 5 {
            loadMoreData()
        }
    }
}

