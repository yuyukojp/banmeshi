//
//  NetWorkTool.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/25.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil,  finishedCallback :  @escaping (_ result : Any) -> ()) {    
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        AF.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
           // guard let resout = response.request?.value(forHTTPHeaderField: URLString) else {
            guard let result = response.value else {
                print(response.error as Any)
                return
            }
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
