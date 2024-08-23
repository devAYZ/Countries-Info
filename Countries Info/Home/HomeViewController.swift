//
//  HomeViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

final class HomeViewController: BaseViewController {

    // MARK: Views
    private var displayView: HomeViews?
    
    override func basicSetup() {
        super.basicSetup()
        //
        setupSideMenu()
        setupViews()
        displayView?.countryTableView.dataSource = self
        displayView?.countryTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func attachViews(_ displayView: HomeViews) {
        self.displayView = displayView
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        guard let displayView = displayView else { return }
        
        view.addSubviews(displayView.headerStack, 
                         displayView.countryTableView,
                         displayView.emptyView)
        
        displayView.countryTableView.refreshControl?.addTarget(
            self,
            action:#selector(handleRefreshList),
            for: .valueChanged)
        
        displayView.sideMenuButton.addTarget(
            self,
            action: #selector(handleSideMenu),
            for: .touchUpInside)
        
        displayView.tryAgainButton.addTarget(
            self,
            action: #selector(handleTryAgain),
            for: .touchUpInside)
        
        displayView.headerStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: displayView.countryTableView.topAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: 5,
            paddingRight: 5)
        
        displayView.countryTableView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 5,
            paddingRight: 5)
        
        displayView.emptyView.anchor(
            top: displayView.headerStack.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor)
        
        // Hide View
        displayView.emptyView.isHidden = true
    }
    
    func attachSideMenu(_ rootVC: SideMenuViewController) {
        sideMenu = SideMenuNavController(rootViewController: rootVC)
        rootVC.delegate = self
    }
    
    @objc private func handleRefreshList() {
        print("refreshControl")
        displayView?.countryTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func handleTryAgain() {
        print("try Again")
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
        coordinator?.openDetails()
    }
    
}
