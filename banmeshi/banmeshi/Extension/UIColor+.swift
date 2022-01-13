//
//  UIColor+.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit

extension UIColor{
    
    //UIColorを16進数カラーコードで初期化できるようにする
    convenience init(hex: String, alpha: CGFloat = 1.0){
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    public static func navigationWhite() -> UIColor {
        
        return UIColor(
            red: 204 / 255.0,
            green: 206 / 255.0,
            blue: 206 / 255.0,
            alpha: 1)
    }
    
    
    public static func whiteTwo() -> UIColor {
        return UIColor(
            red: 224 / 255.0,
            green: 224 / 255.0,
            blue: 224 / 255.0,
            alpha: 1)
    }
    
    public static func delimiterColor() -> UIColor {
        return UIColor(red: 255 / 255.0,
                       green: 230 / 255.0,
                       blue: 234 / 255.0,
                       alpha: 1)
    }
    
    public static func mainBackgroundColor() -> UIColor {
        return UIColor(red: 247 / 255.0,
                       green: 247 / 255.0,
                       blue: 235 / 255.0,
                       alpha: 1)
    }
    
    public static func itemBGColor() -> UIColor {
        return UIColor(red: 230 / 255.0,
                       green: 230 / 255.0,
                       blue: 250 / 255.0,
                       alpha: 1)
    }
    
    public static func textColor() -> UIColor {
        return UIColor(red: 240 / 255.0,
                       green: 124 / 255.0,
                       blue: 154 / 255.0,
                       alpha: 1)
    }
    
    public static func navigation() -> UIColor {
        return UIColor(red: 255 / 255.0,
                       green: 230 / 255.0,
                       blue: 234 / 255.0,
                       alpha: 1)
    }
    
    public static func titleColor() -> UIColor {
        return UIColor(red: 253 / 255.0,
                       green: 102 / 255.0,
                       blue: 104 / 255.0,
                       alpha: 1)
    }
    
    public static func buttonColor() -> UIColor {
        return UIColor(red: 136 / 255.0,
                       green: 117 / 255.0,
                       blue: 227 / 255.0,
                       alpha: 1)
    }
}
