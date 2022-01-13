//
//  CustomButton.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/13.
//

import Foundation
import UIKit

class CusstomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .buttonColor()
        tintColor = .white
        //layerを設定
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 6.0
        layer.masksToBounds = true;
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds;
        gradientLayer.colors = [UIColor(displayP3Red: 136 / 255, green: 117 / 255, blue: 227 / 255,alpha: 1.0).cgColor, UIColor(displayP3Red: 255 / 255, green: 230 / 255, blue: 234 / 255,alpha: 1.0).cgColor]
        layer.insertSublayer(gradientLayer, at:0)
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layer.shadowColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6).cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
