//
//  UIImageView + Extension.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/22/24.
//

import Kingfisher
import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            self.image = .init(named: "dummy")
            return
        }
        self.kf.setImage(with: url, placeholder: UIImage(named: "dummy"))
    }
    
    func loadImage(from url: URL?) {
        guard let url = url else {
            self.image = .init(named: "dummy")
            return
        }
        self.kf.setImage(with: url, placeholder: UIImage(named: "dummy"))
    }
}
