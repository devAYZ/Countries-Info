//
//  SignInViews.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit
import GoogleSignIn

class SignInViews: UIView {

    // MARK: Views
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "Sweden-transparent")
        imageView.contentMode = .center
        imageView.alpha = .pointOne
        return imageView
    }()
    
    lazy var signinButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.anchor(height: 60)
        button.style = .wide
        return button
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.text = "Welcome"
        return label
    }()
    
    lazy var countryInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.text = "Sign in to search and display details of your favourite country"
        label.numberOfLines = .two
        return label
    }()
    
    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            welcomeLabel, countryInfoLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()

    lazy var bodyStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            labelStack,
            signinButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 60
        return stackView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setupViews() {
        
        setupLayout()
    }

    private func setupLayout() {
    }

}
