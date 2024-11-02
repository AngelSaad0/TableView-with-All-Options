//
//  ExpandTableViewCell.swift
//  TableView
//
//  Created by Engy on 11/1/24.
//

import UIKit

class ExpandTableViewCell: UITableViewCell {
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    var butttonClicked: (()->(Void))!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func moreBtnTapped(_ sender: UIButton) {
        // Clousure Calling
        butttonClicked()

    }

}
