//
//  MenuModel.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/29.
//

import UIKit
import RealmSwift
import Foundation
 
class Menu: Object {
    @objc dynamic var id = 0
    //メニュー名
    @objc dynamic var name = ""
    //得点
    @objc dynamic var point = 0
    //TBD.
    @objc dynamic var urlString = ""
    //メニュー詳細設定フラグ
    @objc dynamic var isSetData = false
    //食材
    let ingredients =  List<ingredient>()
 
    override static func primaryKey() -> String? {
        return "id"
    }
    // インデックスの作成
     override static func indexedProperties() -> [String] {
         return ["name"]
     }

}

/// 食材モデル
class ingredient: Object {
    // 食材名
    @objc dynamic var ingredientName: String = ""
    // 分量
    @objc dynamic var amount: String = ""
}
