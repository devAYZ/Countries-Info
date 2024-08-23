//
//  DetailsViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

final class DetailsViewController: BaseViewController {
    
    // MARK: Views
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "Sweden-transparent")
        imageView.alpha = .pointTwo
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "Sweden-transparent")
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 140, height: 140)
        imageView.layer.cornerRadius = 70
        imageView.layer.borderColor = .init(
            red: .zero, green: 1, blue: .zero, alpha: 0.5)
        imageView.layer.borderWidth = 3
        return imageView
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var downView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()

    override func basicSetup() {
        super.basicSetup()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        topView.addSubviews(backgroundImageView, logoImageView)
        
        view.addSubviews(topView,
                         downView)
        
        backgroundImageView.anchor(
            top: topView.topAnchor,
            left: topView.leftAnchor,
            bottom: topView.bottomAnchor,
            right: topView.rightAnchor)
        
        logoImageView.center(inView: topView)
        
        topView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: downView.topAnchor,
            right: view.rightAnchor,
            height: view.frame.height / 3.5)
        
        downView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor)
    }

}
