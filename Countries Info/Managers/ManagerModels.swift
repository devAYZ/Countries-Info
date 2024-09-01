//
//  ManagerModels.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

struct SideMenuList {
    let menuTitle: String
    let menuImage: UIImage?
    
    static func menuList() -> [SideMenuList] {
        let menu: [SideMenuList] = [
            SideMenuList(menuTitle: "Home", menuImage: UIImage(named: "home-menu")),
            SideMenuList(menuTitle: "Settings", menuImage: UIImage(named: "settings-menu")),
        ]
        return menu
    }
}

enum SideMenuOptions: String {
    case home
    case settings
}

class UserProfile: Codable {
    var name: String?
    var email: String?
    var imageURL: URL?
    
    init(name: String? = nil, email: String? = nil, imageURL: URL? = nil) {
        self.name = name
        self.email = email
        self.imageURL = imageURL
    }
}
