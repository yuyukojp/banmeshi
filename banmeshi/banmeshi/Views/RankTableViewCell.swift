//
//  RankTableViewCell.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/12.
//

import UIKit

class RankTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuProgress: UIProgressView!
    @IBOutlet weak var countLabel: UILabel!
    
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
