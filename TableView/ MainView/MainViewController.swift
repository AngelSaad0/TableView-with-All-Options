//
//  MainViewController.swift
//  TableView
//
//  Created by Engy on 11/3/24.
//
struct Item {
    let name: String
    let image: String
    let vc: UIViewController.Type

}
import UIKit

class MainViewController: UIViewController {
    var tableView: UITableView!
    var items: [Item] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupTableView()
        title = "TableView"
    }

    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

    }
    func setupItems() {
        items = [
            Item(name: "Switch", image: "switch.2", vc: TableWithSwitchVC.self),
            Item(name: "Slider", image: "slider.horizontal.3", vc: TableWithSliderVC.self),
            Item(name: "Stepper", image: "plusminus", vc: TableWithStepperVC.self),
            Item(name: "Expandable Table", image: "list.bullet", vc: TableWithExpandCell.self),
            Item(name: "Pull To Refresh", image: "arrow.clockwise", vc: PullToRefreshVC.self),
            Item(name: "Table With Sections", image: "table", vc: TableWithSection.self),
            Item(name: "With Search Bar", image: "magnifyingglass", vc: TableViewWithSearchBar.self),
            Item(name: "Delete Rows Trailing Swipe", image: "square.and.pencil", vc: TableWithDeleteRowsTrailingSwipe.self),
            Item(name: "Leading And Trailing Swipe", image: "ellipsis", vc: TableWithLeadingAndTrailingSwipe.self),
            Item(name: "Context Menu Interaction", image: "list.bullet", vc: TableWithContextMenuInteraction.self),
            Item(name: "Multi Selection", image: "checklist", vc: TableWithMultiSelection.self),
            Item(name: "Drag and Drop Support", image: "arrow.up.arrow.down.circle", vc: TableWithDragandDropSupport.self),
            Item(name: "Pagination And Infinite Scrolling", image: "arrow.left.and.right",vc: TableWithPaginationAndInfiniteScrolling.self)
               ]
    }
}
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.imageView?.image = UIImage(systemName: item.image)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Table View Options"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(items[indexPath.row].vc.init(), animated: true)

    }

}





