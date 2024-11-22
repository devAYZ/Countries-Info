//
//  SettingsViewController.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // MARK: Views
    private var displayView: SettingsViews?
    
    // MARK: Basic Setup
    override func basicSetup() {
        super.basicSetup()
        setupViews()
        setupSideMenu()
        
        displayView?.nameLabel.text = dataManager.userProfile?.name
        displayView?.emailLabel.text = dataManager.userProfile?.email
        displayView?.iconImageView.loadImage(from: dataManager.userProfile?.imageURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "side-menu-icon"), style: .plain,
            target: self, action: #selector(handleSideMenu))
    }
    
    func attachViews(_ displayView: SettingsViews) {
        self.displayView = displayView
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        guard let displayView = displayView else { return }
        
        view.addSubviews(displayView.bodyStack, displayView.footerView)
        
        displayView.footerView.addSubview(displayView.versionLabel)
        
        displayView.signoutButton.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
        displayView.versionLabel.text = dataManager.appVersion
        
        displayView.bodyStack.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 100,
            paddingLeft: 10,
            paddingRight: 10)
        displayView.infoStack.centerX(inView: view)
        
        displayView.footerView.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            width: 80,
            height: 30)
        displayView.footerView.centerX(inView: view)
        
        displayView.versionLabel.center(inView: displayView.footerView)
    }

    func attachSideMenu(_ rootVC: SideMenuViewController) {
        sideMenu = SideMenuNavController(rootViewController: rootVC)
        rootVC.delegate = self
    }
    
    @objc func handleSignout() {
        showAlert(title: SConstants.areYouSure.localize()) { [unowned self] in
            dataManager.logOut()
            coordinator?.openSignin(animated: false)
        }
    }
}

extension SettingsViewController: SideMenuDisplay {
    func didSelectMenu(menu: SideMenuOptions) {
        switchSideMenuSelected(selectedMenu: menu, currentMenu: .settings)
    }
}
