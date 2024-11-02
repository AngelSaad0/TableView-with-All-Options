//
//  TabBarController.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    func setupVC() {
        let vc1 = TableWithSwitchVC()
        vc1.tabBarItem = UITabBarItem(title: "Switch", image: UIImage(systemName: "switch.2"), tag: 0)

        let vc2 = TableWithSliderVC()
        vc2.tabBarItem = UITabBarItem(title: "Slider", image: UIImage(systemName: "slider.horizontal.3"), tag: 1)

        let vc3 = TableWithStepperVC()
        vc3.tabBarItem = UITabBarItem(title: "Stepper", image: UIImage(systemName: "plusminus"), tag: 2)

        let vc4 = TableWithExpandCell()
        vc4.tabBarItem = UITabBarItem(title: "Expandable Table", image: UIImage(systemName: "list.bullet"), tag: 3) 

        let vc5 = PullToRefreshVC()
        vc5.tabBarItem = UITabBarItem(title: "Pull To Refresh", image: UIImage(systemName: "arrow.clockwise"), tag: 4)


        let vc6 = TableWithSection()
        vc6.tabBarItem = UITabBarItem(title: "Table With Sections", image: UIImage(systemName: "table"), tag: 6)
        let vc7 = TableViewWithSearchBar()
        vc7.tabBarItem = UITabBarItem(title: "WithSearchBar", image: UIImage(systemName: "magnifyingglass"), tag: 7)

        let vc8 = TableWithDeleteRowsTrailingSwipe()
        vc8.tabBarItem = UITabBarItem(title: "Delete Rows Trailing Swipe", image: UIImage(systemName: "square.and.pencil"), tag: 8)

        let vc9 = TableWithLeadingAndTrailingSwipe()
        vc9.tabBarItem = UITabBarItem(title: "Leading And Trailing Swipe", image: UIImage(systemName: "ellipsis"), tag: 8)



        viewControllers = [vc1, vc2, vc3, vc4, vc5, vc6,vc7,vc8,vc9]
    }
}
