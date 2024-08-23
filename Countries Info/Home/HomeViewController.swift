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
    
    // MARK: View Model
    private var viewModel: HomeViewModel?
    
    // MARK: Properties
    private var filteredAllCountries: CountriesResponseList? {
        didSet {
            displayView?.countryTableView.reloadData()
        }
    }
    
    var tempData: CountriesResponseList?
    
    override func basicSetup() {
        super.basicSetup()
        //
        setupSideMenu()
        setupViews()
        handleAttachViewModel()
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
    
    func attachViewModel(_ vm: HomeViewModel) {
        viewModel = vm
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        guard let displayView = displayView else { return }
        
        displayView.countryTableView.dataSource = self
        displayView.countryTableView.delegate = self
        displayView.searchBar.delegate = self
        
        view.addSubviews(displayView.headerStack,
                         displayView.searchBar,
                         displayView.countryTableView,
                         displayView.emptyView,
                         displayView.loader)
        
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
        
        displayView.loader.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor)
    }
    
    func attachSideMenu(_ rootVC: SideMenuViewController) {
        sideMenu = SideMenuNavController(rootViewController: rootVC)
        rootVC.delegate = self
    }
    
    @objc private func handleRefreshList() {
        handleTryAgain()
        displayView?.countryTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func handleTryAgain() {
        viewModel?.fetchCountryList()
    }
    
    private func handleAttachViewModel() {
        viewModel?.attachView(view: self)
        
        viewModel?.showLoading = { [weak self] state in
            switch state {
            case true:
                self?.displayView?.loader.isHidden = !state
                self?.displayView?.loader.startAnimating()
            case false:
                self?.displayView?.loader.isHidden = !state
                self?.displayView?.loader.stopAnimating()
            }
        }
        
        dataManager.allCountries == nil ?
        (viewModel?.fetchCountryList()) :
        (setFilterData())
    }
    
    private func setFilterData() {
        filteredAllCountries = dataManager.allCountries
        filteredAllCountries?.isEmpty ?? true ?
        (displayView?.emptyView.isHidden = false) :
        (displayView?.emptyView.isHidden = true)
        tempData = filteredAllCountries
    }
}

extension HomeViewController: SideMenuDisplay {
    func didSelectMenu(menu: SideMenuOptions) {
        switchSideMenuSelected(selectedMenu: menu, currentMenu: .home)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager.allCountries?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTVCell.self)", for: indexPath) as! HomeTVCell
        cell.setupCell(dataManager.allCountries?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.openDetails(selectedCountry: dataManager.allCountries?[indexPath.row])
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
            filteredAllCountries = tempData?.filter({ obj -> Bool in
                return obj.name?.official?.lowercased().contains(searchText.lowercased()) ?? false ||
                obj.name?.common?.lowercased().contains(searchText.lowercased()) ?? false ||
                obj.currencies?.first?.value.name?.lowercased().contains(searchText.lowercased()) ?? false ||
                obj.capital?.first?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
        displayView?.countryTableView.reloadData()
    }
    
}

extension HomeViewController: HomeView {
    func networkCallSuccess(data: CountriesResponseList?) {
        dataManager.allCountries = data
        setFilterData()
    }
    
    func networkCallFailed(error: FError?) {
        showAlert(title: "Error", message: error?.localizedDescription, completion: nil)
    }
}
