//
//  RankModel.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/11.
//

import Foundation
import RealmSwift

class History: Object {
    @objc dynamic var id = 0
    //履歴のメニューid
    @objc dynamic var menuId = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    // インデックスの作成
     override static func indexedProperties() -> [String] {
         return ["name"]
     }
}
