//
//  TestModel.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/25.
//

import Foundation

// MARK: - Welcome
class TestModel: Codable {
    let objects: Objects

    init(objects: Objects) {
        self.objects = objects
    }
}

// MARK: - Object
class Objects: Codable {
    let a, c, e: String

    init(a: String, c: String, e: String) {
        self.a = a
        self.c = c
        self.e = e
    }
}

struct Article: Codable {
    
    let title : String
    let url : String
    
}

struct ArticlesListResult: Codable {
    
    let status : String
    let articles : [Article]
    let totalResults : Int
    
}
