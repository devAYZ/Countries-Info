//
//  SignInViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

class SignInViewController: BaseViewController {

    override func basicSetup() {
        //
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
