//
//  NoMenuDataView.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/6.
//

import UIKit

class NoMenuDataView: UIView {
    @IBOutlet var contentView: NoMenuDataView!
    @IBOutlet weak var messageLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        Bundle.main.loadNibNamed("NoMenuDataView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
