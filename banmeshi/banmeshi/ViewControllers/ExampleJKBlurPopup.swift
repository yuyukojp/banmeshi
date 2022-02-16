//
//  ExamplePopup.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/2/16.
//

import UIKit

class ExampleJKBlurPopup: JKBlurPopup {
    override init(frame: CGRect) {
        super.init(frame: frame)

        let close = UIButton()
        close.setTitle("close", for: .normal)
        close.setTitleColor(UIColor.blue, for: .normal)
        close.frame = CGRect(x: 0, y: 185, width: 300, height: 30)
        close.addTarget(self, action: #selector(btnClose), for: .touchUpInside)
        contentView.addSubview(close)

        print(contentView.frame)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func btnClose() {
        dismiss()
    }
}
