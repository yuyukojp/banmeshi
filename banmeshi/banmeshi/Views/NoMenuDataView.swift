//
//  NoMenuDataView.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/6.
//

import UIKit

class NoMenuDataView: UIView {
    @IBOutlet var contentView: NoMenuDataView!
    let errorImageView: UIImageView = UIImageView()
    let errorMessageLabel1: UILabel = UILabel()
    let errorMessageLabel2: UILabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        Bundle.main.loadNibNamed("NoMenuDataView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        contentView.frame = bounds
        contentView.backgroundColor = .mainBackgroundColor()
        
        errorImageView.image = UIImage(named: "bblive_2233_loading_error_128x94_")
        errorImageView.frame = CGRect(x:0 , y: Const.safeAreaHeight, width: Const.screenWidth, height: 400)
        contentView.addSubview(errorImageView)
        
        var errorLabelY = Const.safeAreaHeight + errorImageView.frame.height + 40
        errorMessageLabel1.frame = CGRect(x: (Const.screenWidth - 280) / 2, y: errorLabelY, width: 280, height: 40)
        errorMessageLabel1.text = "至少需要添加2个以上的菜谱才能转"
        errorMessageLabel1.textColor = .textColor()
        contentView.addSubview(errorMessageLabel1)
        
        errorLabelY += 30
        errorMessageLabel2.frame = CGRect(x: (Const.screenWidth - 180) / 2, y: errorLabelY, width: 180, height: 60)
        errorMessageLabel2.text = "请前往菜单添加菜谱"        
        errorMessageLabel2.textColor = .textColor()
        contentView.addSubview(errorMessageLabel2)
    }
}
