//
//  SideMenuViewController.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/22/24.
//

import SideMenu
import UIKit

typealias SideMenuNavController = SideMenuNavigationController

protocol SideMenuDisplay {
    func didSelectMenu(menu: SideMenuOptions)
}

final class SideMenuViewController: BaseViewController {

    // MARK: Properties
    public var delegate: SideMenuDisplay?
    private var menuList = SideMenuList.menuList()
    
    override func basicSetup() {
        super.basicSetup()
        
        view.backgroundColor = .systemOrange
    }

}
