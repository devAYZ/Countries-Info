//
//  DetailsViews.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

class DetailsViews: UIView {

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
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .link
        label.numberOfLines = 1
        return label
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    /// `Method to create views`
    func listHStackView(_ views: UIView...) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        views.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }

    func listTitleLabel(text: String = .init()) -> UILabel {
        let label = UILabel()
        label.textColor = .link
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.text = text
        return label
    }

    func listValueLabel(text: String = .init()) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }
    
    /// `countryFlag`
    lazy var countryFlagValue: UILabel = {
        listValueLabel()
    }()

    lazy var countryFlagHStack: UIStackView = {
        listHStackView(listTitleLabel(text: SConstants.flag), countryFlagValue)
    }()
    
    /// `countryName`
    lazy var countryNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var countryNameHStack: UIStackView = {
        listHStackView(listTitleLabel(text: SConstants.countryName), countryNameValue)
    }()
    
    /// `capitalName`
    lazy var capitalNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var capitalHStack: UIStackView = {
        listHStackView(listTitleLabel(text: SConstants.capitalCity), capitalNameValue)
    }()
    
    /// `continentName`
    lazy var continentNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var continentNameHStack: UIStackView = {
        listHStackView(listTitleLabel(text: "Continent Name"), continentNameValue)
    }()
    
    /// `continentName`
    lazy var timeZoneValue: UILabel = {
        listValueLabel()
    }()

    lazy var timeZoneHStack: UIStackView = {
        listHStackView(listTitleLabel(text: "Time Zone"), timeZoneValue)
    }()
    
    /// `Population`
    lazy var populationValue: UILabel = {
        listValueLabel()
    }()

    lazy var populationHStack: UIStackView = {
        listHStackView(listTitleLabel(text: "Population"), populationValue)
    }()
    
    /// `currencyName`
    lazy var currencyNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var currencyNameHStack: UIStackView = {
        listHStackView(listTitleLabel(text: "Currency Name"), currencyNameValue)
    }()
    
    /// `currencySign`
    lazy var currencySignValue: UILabel = {
        listValueLabel()
    }()

    lazy var currencySignHStack: UIStackView = {
        listHStackView(listTitleLabel(text: SConstants.currencySign), currencySignValue)
    }()
    
    /// `Body Stack View`
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            countryFlagHStack, countryNameHStack, capitalHStack,
            continentNameHStack, timeZoneHStack, populationHStack,
            currencyNameHStack, currencySignHStack
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    let bottomScrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
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
        
        topView.addSubviews(backgroundImageView, logoImageView, topLabel)
        
        bottomScrollView.addSubview(bottomStackView)
        
        setupLayout()
    }

    private func setupLayout() {
        backgroundImageView.anchor(
            top: topView.topAnchor,
            left: topView.leftAnchor,
            bottom: topView.bottomAnchor,
            right: topView.rightAnchor)
        
        logoImageView.center(inView: topView)
        
        topLabel.anchor(
            left: topView.leftAnchor,
            bottom: topView.bottomAnchor,
            right: topView.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10)
        topLabel.centerX(inView: topView)
    }
}
