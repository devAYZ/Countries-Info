//
//  BaseViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController, DataManagerInjector {
    
    // MARK: Propertites
    public weak var coordinator: AppCoordinator?
    public var sideMenu: SideMenuNavigationController?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Basic Setup
    public func basicSetup() {
        
    }
    
    public func setupSideMenu() {
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
    }
    
    @objc func handleSideMenu() {
        present(sideMenu!, animated: true)
    }
    
    func switchSideMenuSelected(selectedMenu: SideMenuOptions, currentMenu: SideMenuOptions) {
        if selectedMenu == currentMenu {
            sideMenu?.dismiss(animated: true)
        } else {
            sideMenu?.dismiss(animated: false, completion: { [self] in
                switch selectedMenu {
                case .home:
                    coordinator?.openHome()
                case .settings:
                    coordinator?.openSettings()
                }
            })
        }
    }
}
