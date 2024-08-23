//
//  HomeViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: View
    lazy var countryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTVCell.self, forCellReuseIdentifier: "\(HomeTVCell.self)")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: Views
    private lazy var sideMenuButton: UIButton = {
        let button = UIButton()
        button.anchor(width: 30, height: 30)
        button.setImage(.init(named: "side-menu-icon"), for: .normal)
        button.addTarget(self, action: #selector(handleSideMenu), for: .touchUpInside)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = "Favourite Countries List"
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    lazy var headerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            sideMenuButton, topLabel
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    override func basicSetup() {
        super.basicSetup()
        //
        setupSideMenu()
        setupViews()
        countryTableView.dataSource = self
        countryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(headerStack, countryTableView)
        
        headerStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: countryTableView.topAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: 5,
            paddingRight: 5)
        
        countryTableView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 5,
            paddingRight: 5)
    }
    
    public func attachSideMenu(rootVC: SideMenuViewController) {
        sideMenu = SideMenuNavController(rootViewController: rootVC)
        rootVC.delegate = self
    }
}

extension HomeViewController: SideMenuDisplay {
    func didSelectMenu(menu: SideMenuOptions) {
        switchSideMenuSelected(selectedMenu: menu, currentMenu: .home)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTVCell.self)", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
