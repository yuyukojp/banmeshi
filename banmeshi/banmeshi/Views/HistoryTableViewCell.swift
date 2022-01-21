//
//  HistoryTableViewCell.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/13.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var historyNameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
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
