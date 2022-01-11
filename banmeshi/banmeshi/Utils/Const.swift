//
//  Const.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/29.
//

import Foundation
import UIKit

struct Const {
    static let screenBounds = UIScreen.main.bounds
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    //セーフエリアの高さ
    static let safeAreaHeight = CGFloat(67.0)
    //文言

    
}

struct StringConst {

}

struct AlertConst {
    static let alertTitle = "注意！"
    static let noMenuErrorMsg = "请先添加菜谱"
    static let oneMenuErrorMsg = "就一个菜转毛线啊？(无语住了)"
    static let saveAlertTitle = "是否保存？"
    static let saveAlertMsg = "是否储存添加的信息？"
    static let ok = "OK"
    static let cancel = "Cancel"
    static let save = "保存"
    static let noSave = "继续编辑"
    static let noIntroductionTitle = "请注意"
    static let noIntroductionMsg = "未填写简介内容，是否继续保存？"
}
