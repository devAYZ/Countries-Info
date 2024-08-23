//
//  SignInViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import GoogleSignIn
import UIKit

final class SignInViewController: BaseViewController {
    
    // MARK: Views
    private var displayView: SignInViews?

    override func basicSetup() {
        super.basicSetup()
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
    
    func attachViews(_ displayView: SignInViews) {
        self.displayView = displayView
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        guard let displayView = displayView else { return }
        
        view.addSubviews(displayView.backgroundImageView, displayView.bodyStack)
        
        displayView.signinButton.addTarget(
            self,
            action: #selector(handleSignin),
            for: .touchUpInside)
        
        displayView.backgroundImageView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor)
        
        displayView.bodyStack.centerY(inView: view)
        displayView.bodyStack.anchor(
            left: view.leftAnchor,
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
