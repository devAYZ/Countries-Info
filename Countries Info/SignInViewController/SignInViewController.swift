//
//  SignInViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import GoogleSignIn
import UIKit

class SignInViewController: BaseViewController {
    
    // MARK: Views
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "Sweden-transparent")
        imageView.contentMode = .center
        imageView.alpha = .pointOne
        return imageView
    }()
    
    private lazy var signinButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.anchor(height: 60)
        button.style = .wide
        button.addTarget(self, action: #selector(handleSignin), for: .touchUpInside)
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
        stackView.spacing = 30
        return stackView
    }()

    override func basicSetup() {
        //
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(backgroundImageView, bodyStack)
        
        backgroundImageView.anchor(top: view.topAnchor,
                                   left: view.leftAnchor,
                                   bottom: view.bottomAnchor,
                                   right: view.rightAnchor)
        
        view.addSubview(bodyStack)
        bodyStack.centerY(inView: view)
        bodyStack.anchor(left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 12,
                         paddingRight: 12)
        
    }
    
    @objc private func handleSignin() {
        // Google Signin
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                self.showAlert(title: "Error", message: error?.localizedDescription, completion: nil)
                return
            }
            
            // If sign in succeeded, display the app's main content View.
            guard let result = signInResult else {
                self.showAlert(title: "Error", message: "Data Not Found", completion: nil)
                return
            }
            self.dataManager.userProfile = result.user.profile
            self.coordinator?.openHome()
        }
    }
    
}
