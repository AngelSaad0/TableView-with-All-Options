//
//  TableWithSliderVC.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//
struct SettingItem1 {
    let title: String
    let min: Float
    let max: Float
    // var to allow updates
    var initialValue: Float
}

import UIKit

class TableWithSliderVC: UIViewController {
    @IBOutlet var tableView:UITableView!
    var item: [SettingItem1] = [
        SettingItem1(title: "Brightness", min: 0.0, max: 1.0, initialValue: Float(UIScreen.main.brightness)),
        SettingItem1(title: "Sound Volume", min: 0.0, max: 1.0, initialValue: 0.5)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white.withAlphaComponent(CGFloat(item[0].initialValue))

        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension TableWithSliderVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = item[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        // Create UISlider
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.minimumValue = setting.min
        slider.maximumValue = setting.max
        slider.value = setting.initialValue
        slider.tag = indexPath.row
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        // Create a label to display the current value


        // Content
        var content = cell.defaultContentConfiguration()
        content.text = setting.title
        content.textProperties.color = .blue
        content.secondaryText = String(format: "%.3f", setting.initialValue)
        content.secondaryTextProperties.color = .blue


        // Setup cell

        cell.contentConfiguration = content
        cell.accessoryView = slider
        cell.backgroundColor = .white.withAlphaComponent(0)
        return cell
    }

    @objc func sliderValueChanged(_ sender: UISlider){

        if sender.tag == 0 {
            item[sender.tag].initialValue = sender.value

            if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) {
                let valueLabels = cell.contentView.subviews.compactMap({$0 as? UILabel})
                if valueLabels.count>1 {
                    valueLabels[1].text = String(format: "%.2f", sender.value)
                }

            }
            // UIScreen brightness doesn't work in simulator so we are  testing color chaning in table
            UIScreen.main.brightness = CGFloat(sender.value)
            tableView.backgroundColor = .black.withAlphaComponent(CGFloat(1 - sender.value))
        }

    }

}


//func updateAllSence(_ isDarkMode: Bool) {
//    let scenes = UIApplication.shared.connectedScenes
//    let windowScene = scenes.first{$0 is UIWindowScene} as? UIWindowScene
//    windowScene?.windows.forEach{ window in
//        window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
//
//
//    }
//        tableView.visibleCells.forEach{$0.backgroundColor = .black.withAlphaComponent(CGFloat(sender.value))}



