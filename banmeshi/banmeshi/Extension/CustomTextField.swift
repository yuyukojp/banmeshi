//
//  CustomTextFiled.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/14.
//

import Foundation
import UIKit

class CustomTextField : UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .itemBGColor()
        tintColor = .textColor()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds;
        gradientLayer.cornerRadius = 6.0
        gradientLayer.masksToBounds = true;
        gradientLayer.colors = [UIColor(displayP3Red: 136 / 255, green: 117 / 255, blue: 227 / 255,alpha: 1.0).cgColor, UIColor(displayP3Red: 255 / 255, green: 230 / 255, blue: 234 / 255,alpha: 1.0).cgColor]
        gradientLayer.shadowColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6).cgColor
        gradientLayer.shadowOffset = CGSize(width: 3, height: 3)
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.shadowRadius = 5
        layer.insertSublayer(gradientLayer, at:0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
