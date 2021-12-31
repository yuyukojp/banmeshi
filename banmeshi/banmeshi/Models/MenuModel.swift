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
    //紹介文
    @objc dynamic var introduction = ""
    //メニュー詳細設定フラグ
    @objc dynamic var isSetData = false
    //食材
//    let ingredients =  List<Ingredient>()
 
    override static func primaryKey() -> String? {
        return "id"
    }
    // インデックスの作成
     override static func indexedProperties() -> [String] {
         return ["name"]
     }

}

///// 食材モデル
//class Ingredient: Object {
//    // 食材名
//    @objc dynamic var ingredientName: String = ""
//    // 分量
//    @objc dynamic var amount: String = ""
//}

class MenuDetail: Object {
    @objc dynamic var menuId = 0
    @objc dynamic var menuCount = 0
    // 食材名
    @objc dynamic var ingredientName0 = ""
    @objc dynamic var ingredientName1 = ""
    @objc dynamic var ingredientName2 = ""
    @objc dynamic var ingredientName3 = ""
    @objc dynamic var ingredientName4 = ""
    @objc dynamic var ingredientName5 = ""
    @objc dynamic var ingredientName6 = ""
    @objc dynamic var ingredientName7 = ""
    @objc dynamic var ingredientName8 = ""
    @objc dynamic var ingredientName9 = ""
    @objc dynamic var ingredientName10 = ""
    @objc dynamic var ingredientName11 = ""
    @objc dynamic var ingredientName12 = ""
    @objc dynamic var ingredientName13 = ""
    @objc dynamic var ingredientName14 = ""
    @objc dynamic var ingredientName15 = ""
    @objc dynamic var ingredientName16 = ""
    @objc dynamic var ingredientName17 = ""
    @objc dynamic var ingredientName18 = ""
    @objc dynamic var ingredientName19 = ""
    @objc dynamic var ingredientName20 = ""
    @objc dynamic var ingredientName21 = ""
    @objc dynamic var ingredientName22 = ""
    @objc dynamic var ingredientName23 = ""
    @objc dynamic var ingredientName24 = ""
    @objc dynamic var ingredientName25 = ""
    @objc dynamic var ingredientName26 = ""
    @objc dynamic var ingredientName27 = ""
    @objc dynamic var ingredientName28 = ""
    @objc dynamic var ingredientName29 = ""
    @objc dynamic var ingredientName30 = ""
    
    // 分量
    @objc dynamic var amount0 = ""
    @objc dynamic var amount1 = ""
    @objc dynamic var amount2 = ""
    @objc dynamic var amount3 = ""
    @objc dynamic var amount4 = ""
    @objc dynamic var amount5 = ""
    @objc dynamic var amount6 = ""
    @objc dynamic var amount7 = ""
    @objc dynamic var amount8 = ""
    @objc dynamic var amount9 = ""
    @objc dynamic var amount10 = ""
    @objc dynamic var amount11 = ""
    @objc dynamic var amount12 = ""
    @objc dynamic var amount13 = ""
    @objc dynamic var amount14 = ""
    @objc dynamic var amount15 = ""
    @objc dynamic var amount16 = ""
    @objc dynamic var amount17 = ""
    @objc dynamic var amount18 = ""
    @objc dynamic var amount19 = ""
    @objc dynamic var amount20 = ""
    @objc dynamic var amount21 = ""
    @objc dynamic var amount22 = ""
    @objc dynamic var amount23 = ""
    @objc dynamic var amount24 = ""
    @objc dynamic var amount25 = ""
    @objc dynamic var amount26 = ""
    @objc dynamic var amount27 = ""
    @objc dynamic var amount28 = ""
    @objc dynamic var amount29 = ""
    @objc dynamic var amount30 = ""
    
}
