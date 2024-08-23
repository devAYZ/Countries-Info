//
//  UIViewController + Extension.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/22/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String? = nil, action1: String = "Cancel",
                   action2: String = "OK", completion: (() -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: action1, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: action2, style: .default, handler: { (action) in
            completion?()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}