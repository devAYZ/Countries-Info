//
//  InterceptorViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

final class InterceptorViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    // MARK: Lifecycle Methods
    override func basicSetup() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.openNavigation()
        }
        
        view.backgroundColor = .red
    }
    
    private func openNavigation() {
        
    }
}
