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
        displayView?.topLabel.text = countryData?.name?.official ?? .orNA
        
        displayView?.countryNameValue.text = countryData?.name?.common ?? .orNA
        displayView?.capitalNameValue.text = countryData?.capital?.first ?? .orNA
        displayView?.currencyNameValue.text = countryData?.currencies?.first?.value.name ?? .orNA
        displayView?.currencySignValue.text = countryData?.currencies?.first?.value.symbol ?? .orNA
        displayView?.countryFlagValue.text = countryData?.flag ?? .orNA
        displayView?.continentNameValue.text = countryData?.continents?.first ?? .orNA
        displayView?.timeZoneValue.text = countryData?.timezones?.first ?? .orNA
        displayView?.populationValue.text = (countryData?.population ?? 0).addCommaDelimiter()

    }
    
    func attachViews(_ displayView: DetailsViews) {
        self.displayView = displayView
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        guard let displayView = displayView else { return }
        
        view.addSubviews(displayView.topView, displayView.bottomScrollView)
        
        displayView.topView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: displayView.bottomScrollView.topAnchor,
            right: view.rightAnchor,
            height: view.frame.height / 3.5)
        
        displayView.bottomScrollView.anchor(
            top: displayView.topView.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor)
        
        displayView.bottomStackView.anchor(
            top: displayView.bottomScrollView.topAnchor,
            left: view.leftAnchor,
            bottom: displayView.bottomScrollView.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 16)
    }

}
