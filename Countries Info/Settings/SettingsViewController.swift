//
//  SettingsViewController.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//

import UIKit

final class SettingsViewController: BaseViewController {

    // MARK: Views
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 70, height: 70)
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var headerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView, nameLabel, emailLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var signoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        button.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
        button.backgroundColor = .systemRed.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.text = "v1.0.0"
        return label
    }()
    
    override func basicSetup() {
        super.basicSetup()
        setupViews()
        setupSideMenu()
        
        nameLabel.text = dataManager.userProfile?.name
        emailLabel.text = dataManager.userProfile?.email
        iconImageView.loadImage(from: dataManager.userProfile?.imageURL(withDimension: 200))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "side-menu-icon"), style: .plain,
            target: self, action: #selector(handleSideMenu))
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(headerStack, signoutButton, footerView)
        
        footerView.addSubview(versionLabel)
        
        headerStack.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 100,
            paddingLeft: 10,
            paddingRight: 10)
        headerStack.centerX(inView: view)
        
        signoutButton.anchor(
            left: view.leftAnchor,
            bottom: footerView.topAnchor,
            right: view.rightAnchor,
            paddingLeft: 12,
            paddingBottom: 12,
            paddingRight: 12,
            height: 50)
        
        footerView.anchor(
            bottom: view.bottomAnchor,
            width: 80,
            height: 30)
        footerView.centerX(inView: view)
        
        versionLabel.center(inView: footerView)
    }

    public func attachSideMenu(rootVC: SideMenuViewController) {
        sideMenu = SideMenuNavController(rootViewController: rootVC)
        rootVC.delegate = self
    }
    
    @objc public func handleSignout() {
        showAlert(title: "Are you sure?") { [unowned self] in
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
