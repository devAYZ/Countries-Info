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
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
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
        
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "Google_Signin") {
            // This is the expiration handler.
            // It is called if the background time is about to expire.
            self.endBackgroundTask()
        }
        
        // Google Signin
        Google_Signin()
        
        endBackgroundTask()
    }
    
    private func Google_Signin() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                self.showAlert(title: SConstants.error, message: error?.localizedDescription, completion: nil)
                return
            }
            
            // If sign in succeeded, display the app's main content View.
            guard let result = signInResult else {
                self.showAlert(title: SConstants.error, message: SConstants.dataNF, completion: nil)
                return
            }
            self.dataManager.userProfile = .init(
                name: result.user.profile?.name,
                email: result.user.profile?.email,
                imageURL: result.user.profile?.imageURL(withDimension: .image200)
            )
            self.coordinator?.openHome()
        }
    }
    
    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
    
}
