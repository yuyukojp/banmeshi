//
//  Alert.swift
//  banmeshi
//
//  Created by 金斗石 on 2021/12/28.
//

import UIKit

enum Alert {
    /// OK Alert
    static func okAlert(title: String, message: String, on viewController: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

    /// OK & Cancel Alert
    static func okCancelAlert(title: String, message: String, on viewController: UIViewController, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
