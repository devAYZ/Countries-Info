//
//  NavigationDirectorViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

final class NavigationDirectorViewController: BaseViewController {
    
    // MARK: Views
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "Sweden-transparent")
        imageView.contentMode = .center
        imageView.alpha = .pointTwo
        return imageView
    }()
    
    // MARK: Lifecycle Methods
    override func basicSetup() {
        super.basicSetup()
        
        setupViews()
        zoomInLogo(backgroundImageView)
    }
    
    private func openNavigation() {
        dataManager.userProfile == nil ?
        coordinator?.openSignin() :
        coordinator?.openHome(animated: false)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        
        backgroundImageView.anchor(top: view.topAnchor,
                                   left: view.leftAnchor,
                                   bottom: view.bottomAnchor,
                                   right: view.rightAnchor)
    }
    
    /// Add zoom effect to UIImageView
    /// - Parameter image: image to apply zoom effect on
    private func zoomInLogo(_ image: UIImageView) {
        UIView.animate(withDuration: 0.6, animations: {() -> Void in
            image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 0.8, animations: {() -> Void in
                image.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            }) { _ in
                self.openNavigation()
            }
        }
    }
}
