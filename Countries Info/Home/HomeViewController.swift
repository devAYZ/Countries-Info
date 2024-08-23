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
    var networkClass = NetworkClass()
    
    // MARK: Properties
    private var filteredAllCountries: CountriesResponseList? {
        didSet {
            displayView?.countryTableView.reloadData()
        }
    }
    
    override func basicSetup() {
        super.basicSetup()
        //
        setupSideMenu()
        setupViews()
        displayView?.countryTableView.dataSource = self
        displayView?.countryTableView.delegate = self
        
//        networkClass.makeNetworkCall(urlString: .allCountries) { (result: Result<CountriesResponseList, NetworkError>) in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let data):
//                print(data.count)
//            }
//        }
        
//        networkClass.makeNetworkCall_AF(urlString: .allCountries) { (response: FResponse<CountriesResponseList, FError>) in
//            switch response.result {
//            case .success(let data):
//                self.dataManager.allCountries = data
//            case .failure(let error):
//                self.showAlert(title: "Error", message: error.localizedDescription, completion: nil)
//            }
//        }
        
        filteredAllCountries = dataManager.allCountries
        filteredAllCountries?.isEmpty ?? true ?
        (displayView?.emptyView.isHidden = false) :
        (displayView?.emptyView.isHidden = true)
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
                         displayView.searchBar,
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
        
        displayView.searchBar.delegate = self
        
        displayView.headerStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: displayView.searchBar.topAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: 5,
            paddingRight: 5)
        
        displayView.searchBar.anchor(
            left: view.leftAnchor,
            bottom: displayView.countryTableView.topAnchor,
            right: view.rightAnchor,
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
        dataManager.allCountries?.prefix(20).count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTVCell.self)", for: indexPath) as! HomeTVCell
        cell.setupCell(dataManager.allCountries?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.openDetails()
    }
}


extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredAllCountries = dataManager.allCountries
            return
        } else {
            filteredAllCountries = dataManager.allCountries?.filter({ obj -> Bool in
                return obj.name?.official?.lowercased().contains(searchText.lowercased()) ?? false ||
                obj.name?.common?.lowercased().contains(searchText.lowercased()) ?? false ||
                obj.currencies?.first?.value.name?.lowercased().contains(searchText.lowercased()) ?? false ||
                obj.capital?.first?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
    }
    
}
