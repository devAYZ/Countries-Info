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
    
    // MARK: Views
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 70, height: 70)
        imageView.layer.cornerRadius = 35
        imageView.layer.borderColor = .init(
            red: .zero, green: 100, blue: .zero, alpha: 0.5)
        imageView.layer.borderWidth = 3
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
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SideMenuTVCell.self, forCellReuseIdentifier: "\(SideMenuTVCell.self)")
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        return tableView
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
        label.text = dataManager.appVersion
        return label
    }()

    // MARK: Properties
    var delegate: SideMenuDisplay?
    private var menuList = SideMenuList.menuList()
    
    override func basicSetup() {
        super.basicSetup()
        
        setupViews()
        setupTableView()
        
        nameLabel.text = dataManager.userProfile?.name
        emailLabel.text = dataManager.userProfile?.email
        iconImageView.loadImage(from: dataManager.userProfile?.imageURL)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(headerStack, menuTableView, footerView)
        
        footerView.addSubview(versionLabel)
        
        headerStack.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: menuTableView.topAnchor,
            right: view.rightAnchor,
            paddingTop: 100,
            paddingLeft: 10,
            paddingBottom: 20,
            paddingRight: 10)
        headerStack.centerX(inView: view)
        
        menuTableView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10)
        
        footerView.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            width: 80,
            height: 30)
        footerView.centerX(inView: view)
        
        versionLabel.center(inView: footerView)
    }

    func setupTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.tableFooterView = UIView()
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SideMenuTVCell.self)", for: indexPath) as! SideMenuTVCell
        cell.setupCell(list: menuList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectMenu(menu: .init(rawValue: menuList[indexPath.row].menuTitle.lowercased()) ?? .home)
    }
}
