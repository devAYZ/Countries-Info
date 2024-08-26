//
//  AppCoordinator.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

protocol Coordinator {
    
    // MARK: Propertites
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationDirector()
    }
    
    func navigationDirector() {
        let vc = NavigationDirectorViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openSignin(animated: Bool = true) {
        let vc = SignInViewController()
        vc.coordinator = self
        vc.attachViews(.init())
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func openHome(animated: Bool = true) {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.attachViews(.init())
        vc.attachSideMenu(.init())
        vc.attachViewModel(.init())
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func openDetails(selectedCountry: CountriesResponse? = nil) {
        let vc = DetailsViewController()
        vc.coordinator = self
        vc.countryData = selectedCountry
        vc.attachViews(.init())
        navigationController.present(vc, animated: true)
    }
    
    func openSettings() {
        let vc = SettingsViewController()
        vc.coordinator = self
        vc.attachViews(.init())
        vc.attachSideMenu(.init())
        navigationController.pushViewController(vc, animated: true)
    }
    
}
