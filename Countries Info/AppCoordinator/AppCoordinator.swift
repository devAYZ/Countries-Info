//
//  AppCoordinator.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

public protocol Coordinator {
    
    // MARK: Propertites
    var navigationController: UINavigationController { get set }
    
    func start()
}


public class AppCoordinator: Coordinator {
    
    // MARK: Properties
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        navigationDirector()
    }
    
    func navigationDirector() {
        let vc = InterceptorViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openSignin() {
        let vc = SignInViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openHome() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
}
