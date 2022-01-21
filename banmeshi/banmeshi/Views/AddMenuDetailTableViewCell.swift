//
//  AddMenuDetailTableViewCell.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/31.
//

import UIKit

class AddMenuDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amfeLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    
    
    
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
