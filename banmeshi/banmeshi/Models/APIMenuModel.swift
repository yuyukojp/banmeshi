//
//  APIMenu.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/24.
//
import Foundation

// MARK: - WelcomeValue
class APIMenuModel: Codable {
    let menu: APIMenu
    let menudetail: Menudetail

    init(menu: APIMenu, menudetail: Menudetail) {
        self.menu = menu
        self.menudetail = menudetail
    }
}

// MARK: - Menu
class APIMenu: Codable {
    let id: Int
    let name: String
    let point: Int
    let imageData, introduction: String
    let isSetData: Bool
    let rouletteCount: Int

    init(id: Int, name: String, point: Int, imageData: String, introduction: String, isSetData: Bool, rouletteCount: Int) {
        self.id = id
        self.name = name
        self.point = point
        self.imageData = imageData
        self.introduction = introduction
        self.isSetData = isSetData
        self.rouletteCount = rouletteCount
    }
}

// MARK: - Menudetail
class Menudetail: Codable {
    let menuID, menuCount: Int
    let ingredientName0, ingredientName1, ingredientName2, ingredientName3: String
    let ingredientName4, ingredientName5, ingredientName6, ingredientName7: String
    let ingredientName8, ingredientName9, ingredientName10, ingredientName11: String
    let ingredientName12, ingredientName13, ingredientName14, ingredientName15: String
    let ingredientName16, ingredientName17, ingredientName18, ingredientName19: String
    let ingredientName20, ingredientName21, ingredientName22, ingredientName23: String
    let ingredientName24, ingredientName25, ingredientName26, ingredientName27: String
    let ingredientName28, ingredientName29, ingredientName30, amount0: String
    let amount1, amount2, amount3, amount4: String
    let amount5, amount6, amount7, amount8: String
    let amount9, amount10, amount11, amount12: String
    let amount13, amount14, amount15, amount16: String
    let amount17, amount18, amount19, amount20: String
    let amount21, amount22, amount23, amount24: String
    let amount25, amount26, amount27, amount28: String
    let amount29, amount30: String

    enum CodingKeys: String, CodingKey {
        case menuID = "menuId"
        case menuCount, ingredientName0, ingredientName1, ingredientName2, ingredientName3, ingredientName4, ingredientName5, ingredientName6, ingredientName7, ingredientName8, ingredientName9, ingredientName10, ingredientName11, ingredientName12, ingredientName13, ingredientName14, ingredientName15, ingredientName16, ingredientName17, ingredientName18, ingredientName19, ingredientName20, ingredientName21, ingredientName22, ingredientName23, ingredientName24, ingredientName25, ingredientName26, ingredientName27, ingredientName28, ingredientName29, ingredientName30, amount0, amount1, amount2, amount3, amount4, amount5, amount6, amount7, amount8, amount9, amount10, amount11, amount12, amount13, amount14, amount15, amount16, amount17, amount18, amount19, amount20, amount21, amount22, amount23, amount24, amount25, amount26, amount27, amount28, amount29, amount30
    }

    init(menuID: Int, menuCount: Int, ingredientName0: String, ingredientName1: String, ingredientName2: String, ingredientName3: String, ingredientName4: String, ingredientName5: String, ingredientName6: String, ingredientName7: String, ingredientName8: String, ingredientName9: String, ingredientName10: String, ingredientName11: String, ingredientName12: String, ingredientName13: String, ingredientName14: String, ingredientName15: String, ingredientName16: String, ingredientName17: String, ingredientName18: String, ingredientName19: String, ingredientName20: String, ingredientName21: String, ingredientName22: String, ingredientName23: String, ingredientName24: String, ingredientName25: String, ingredientName26: String, ingredientName27: String, ingredientName28: String, ingredientName29: String, ingredientName30: String, amount0: String, amount1: String, amount2: String, amount3: String, amount4: String, amount5: String, amount6: String, amount7: String, amount8: String, amount9: String, amount10: String, amount11: String, amount12: String, amount13: String, amount14: String, amount15: String, amount16: String, amount17: String, amount18: String, amount19: String, amount20: String, amount21: String, amount22: String, amount23: String, amount24: String, amount25: String, amount26: String, amount27: String, amount28: String, amount29: String, amount30: String) {
        self.menuID = menuID
        self.menuCount = menuCount
        self.ingredientName0 = ingredientName0
        self.ingredientName1 = ingredientName1
        self.ingredientName2 = ingredientName2
        self.ingredientName3 = ingredientName3
        self.ingredientName4 = ingredientName4
        self.ingredientName5 = ingredientName5
        self.ingredientName6 = ingredientName6
        self.ingredientName7 = ingredientName7
        self.ingredientName8 = ingredientName8
        self.ingredientName9 = ingredientName9
        self.ingredientName10 = ingredientName10
        self.ingredientName11 = ingredientName11
        self.ingredientName12 = ingredientName12
        self.ingredientName13 = ingredientName13
        self.ingredientName14 = ingredientName14
        self.ingredientName15 = ingredientName15
        self.ingredientName16 = ingredientName16
        self.ingredientName17 = ingredientName17
        self.ingredientName18 = ingredientName18
        self.ingredientName19 = ingredientName19
        self.ingredientName20 = ingredientName20
        self.ingredientName21 = ingredientName21
        self.ingredientName22 = ingredientName22
        self.ingredientName23 = ingredientName23
        self.ingredientName24 = ingredientName24
        self.ingredientName25 = ingredientName25
        self.ingredientName26 = ingredientName26
        self.ingredientName27 = ingredientName27
        self.ingredientName28 = ingredientName28
        self.ingredientName29 = ingredientName29
        self.ingredientName30 = ingredientName30
        self.amount0 = amount0
        self.amount1 = amount1
        self.amount2 = amount2
        self.amount3 = amount3
        self.amount4 = amount4
        self.amount5 = amount5
        self.amount6 = amount6
        self.amount7 = amount7
        self.amount8 = amount8
        self.amount9 = amount9
        self.amount10 = amount10
        self.amount11 = amount11
        self.amount12 = amount12
        self.amount13 = amount13
        self.amount14 = amount14
        self.amount15 = amount15
        self.amount16 = amount16
        self.amount17 = amount17
        self.amount18 = amount18
        self.amount19 = amount19
        self.amount20 = amount20
        self.amount21 = amount21
        self.amount22 = amount22
        self.amount23 = amount23
        self.amount24 = amount24
        self.amount25 = amount25
        self.amount26 = amount26
        self.amount27 = amount27
        self.amount28 = amount28
        self.amount29 = amount29
        self.amount30 = amount30
    }
}

typealias APIMenuModels = [String: APIMenuModel]
