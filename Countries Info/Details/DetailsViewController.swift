//
//  DetailsViewController.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

final class DetailsViewController: BaseViewController {
    
    // MARK: Views
    private var displayView: DetailsViews?
    
    // MARK: Properties
    var countryData: CountriesResponse?

    override func basicSetup() {
        super.basicSetup()
        
        setupViews()
        
        [displayView?.backgroundImageView, displayView?.logoImageView
        ].forEach { $0?.loadImage(from: countryData?.flags?.png) }
        displayView?.topLabel.text = countryData?.name?.official
        
        displayView?.countryNameValue.text = countryData?.name?.official
        displayView?.capitalNameValue.text = countryData?.capital?.first
        displayView?.currencyNameValue.text = countryData?.currencies?.first?.value.name
        displayView?.currencySignValue.text = countryData?.currencies?.first?.value.symbol
        displayView?.countryFlagValue.text = countryData?.flag
    }
    
    func attachViews(_ displayView: DetailsViews) {
        self.displayView = displayView
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        guard let displayView = displayView else { return }
        
        view.addSubviews(displayView.topView, displayView.downView)
        
        displayView.topView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: displayView.downView.topAnchor,
            right: view.rightAnchor,
            height: view.frame.height / 3.5)
        
        displayView.downView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor)
    }

}
