//
//  InterceptorViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

final class InterceptorViewController: BaseViewController {
    
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
        
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { _ in
            self.openNavigation()
        }
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
        UIView.animate(withDuration: 0.9, animations: {() -> Void in
            image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 0.9, animations: {() -> Void in
                image.transform = CGAffineTransform(scaleX: 3.4, y: 3.4)
            }) { _ in
                // Do nothing
            }
        }
    }
}
