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
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .link
        return label
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    func listHStackView(_ views: UIView...) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        views.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }

    func listTitleLabel(text: String = "") -> UILabel {
        let label = UILabel()
        label.textColor = .link
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.text = text
        return label
    }

    func listValueLabel(text: String = "") -> UILabel {
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
    lazy var countryFlagTitle: UILabel = {
        listTitleLabel(text: "Flag")
    }()

    lazy var countryFlagValue: UILabel = {
        listValueLabel()
    }()

    lazy var countryFlagHStack: UIStackView = {
        listHStackView(countryFlagTitle, countryFlagValue)
    }()
    
    /// `countryName`
    lazy var countryNameTitle: UILabel = {
        listTitleLabel(text: "Country Name")
    }()

    lazy var countryNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var countryNameHStack: UIStackView = {
        listHStackView(countryNameTitle, countryNameValue)
    }()
    
    /// `capitalName`
    lazy var capitalNameTitle: UILabel = {
        listTitleLabel(text: "Capital City")
    }()

    lazy var capitalNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var capitalHStack: UIStackView = {
        listHStackView(capitalNameTitle, capitalNameValue)
    }()
    
    /// `currencyName`
    lazy var currencyNameTitle: UILabel = {
        listTitleLabel(text: "Currency Name")
    }()

    lazy var currencyNameValue: UILabel = {
        listValueLabel()
    }()

    lazy var currencyNameHStack: UIStackView = {
        listHStackView(currencyNameTitle, currencyNameValue)
    }()
    
    /// `currencySign`
    lazy var currencySignTitle: UILabel = {
        listTitleLabel(text: "Currency Sign")
    }()

    lazy var currencySignValue: UILabel = {
        listValueLabel()
    }()

    lazy var currencySignHStack: UIStackView = {
        listHStackView(currencySignTitle, currencySignValue)
    }()
    
    /// `Body Stack View`
    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            countryFlagHStack,
            countryNameHStack, capitalHStack,
            currencyNameHStack, currencySignHStack
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var downView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
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
        
        downView.addSubview(bodyStackView)
        
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
            paddingLeft: 4,
            paddingBottom: 4,
            paddingRight: 4)
        topLabel.centerX(inView: topView)
        
        bodyStackView.anchor(
            top: downView.topAnchor,
            left: downView.leftAnchor,
            right: downView.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16)
    }
}
