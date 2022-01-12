//
//  MenuDetailTableViewCell.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/30.
//

import UIKit

class MenuDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setCellLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setCellLayout() {
        self.frame.size.width = Const.screenWidth
        self.backgroundColor = .mainBackgroundColor()
    }
}
