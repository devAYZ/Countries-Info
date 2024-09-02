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
    
    override func basicSetup() {
        super.basicSetup()
        //
        setupSideMenu()
        setupViews()
        DispatchQueue.main.async {
            self.handleAttachViewModel()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "side-menu-icon"), style: .plain,
            target: self, action: #selector(handleSideMenu))
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 25, weight: .medium)
        ]
        setupSearchController()
    }
    
    override func loadView() {
        super.loadView()
        view = displayView?.containerView
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
        
        title = SConstants.favCountriesList
        
        displayView.countryTableView.dataSource = self
        displayView.countryTableView.delegate = self
        
        displayView.countryTableView.refreshControl?.addTarget(
            self,
            action:#selector(handleRefreshList),
            for: .valueChanged)
        
        displayView.tryAgainButton.addTarget(
            self,
            action: #selector(refetchCountryList),
            for: .touchUpInside)
    }
    
    func setupSearchController() {
        guard let displayView = displayView else { return }
        
        displayView.searchController.searchResultsUpdater = self        
        navigationItem.searchController = displayView.searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func attachSideMenu(_ rootVC: SideMenuViewController) {
        sideMenu = SideMenuNavController(rootViewController: rootVC)
        rootVC.delegate = self
    }
    
    @objc private func handleRefreshList() {
        refetchCountryList()
        displayView?.countryTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func refetchCountryList() {
        viewModel?.fetchCountryList()
    }
    
    private func handleAttachViewModel() {
        viewModel?.attachView(view: self)
        
        viewModel?.showLoading = { [weak self] state in
            self?.displayView?.startLoader(state)
        }
        
        dataManager.allCountries == nil ? (viewModel?.fetchCountryList()) :
        (displayFetchedList())
    }
    
    private func displayFetchedList() {
        filteredAllCountries = dataManager.allCountries
        filteredAllCountries?.isEmpty ?? true ?
        (displayView?.emptyView.isHidden = false) :
        (displayView?.emptyView.isHidden = true)
        
        displayView?.startLoader(false)
    }
}

extension HomeViewController: SideMenuDisplay {
    func didSelectMenu(menu: SideMenuOptions) {
        switchSideMenuSelected(selectedMenu: menu, currentMenu: .home)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredAllCountries?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTVCell.self)", for: indexPath) as! HomeTVCell
        cell.setupCell(filteredAllCountries?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.openDetails(selectedCountry: filteredAllCountries?[indexPath.row])
    }
}


extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
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

extension HomeViewController: HomeView {
    func networkCallSuccess(data: CountriesResponseList?) {
        dataManager.allCountries = data?.sorted(by: {
            $0.name?.common ?? "" < $1.name?.common ?? ""
        })
        displayFetchedList()
    }
    
    func networkCallFailed(error: FError?) {
        showAlert(
            title: SConstants.error,
            message: error?.localizedDescription,
            completion: nil)
    }
}
