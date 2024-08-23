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
        imageView.alpha = .pointTwo
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 140, height: 120)
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = .init(
            red: .zero, green: .zero, blue: .zero, alpha: 0.8)
        imageView.layer.borderWidth = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground.withAlphaComponent(0.9)
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
    
    // MARK: Properties
    var countryData: CountriesResponse?

    override func basicSetup() {
        super.basicSetup()
        
        setupViews()
        
//        countryLabel.text = data?.name?.official
//        cityLabel.text = data?.capital?.first
//        currencyLabel.text = data?.currencies?.first?.value.symbol
//        iconImageView.loadImage(from: data?.flags?.png)
        [backgroundImageView, logoImageView
        ].forEach { $0.loadImage(from: countryData?.flags?.png) }
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
