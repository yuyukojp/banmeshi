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
    @objc dynamic var name = ""
    @objc dynamic var point = 0
    @objc dynamic var urlString = ""
    @objc dynamic var isSetData = false
//    @objc dynamic var Ingredients = ["",""]
//    @objc dynamic var imageUrl = 
 
    override static func primaryKey() -> String? {
        return "id"
    }
}
