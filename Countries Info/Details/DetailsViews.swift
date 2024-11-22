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
        imageView.anchor(width: 140, height: 110)
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = .init(
            red: .zero, green: .zero, blue: .zero, alpha: 0.8)
        imageView.layer.borderWidth = 6
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
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
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

    func itemTitleLabel(text: String = .init()) -> UILabel {
        let label = UILabel()
        label.textColor = .link
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.text = text
        return label
    }

    func itemValueLabel(text: String = .init()) -> UILabel {
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
        itemValueLabel()
    }()
    
    /// `countryName`
    lazy var countryNameValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `capitalName`
    lazy var capitalNameValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `continentName`
    lazy var continentNameValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `continentName`
    lazy var timeZoneValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `Population`
    lazy var populationValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `currencyName`
    lazy var currencyNameValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `currencySign`
    lazy var currencySignValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `startOFWeekValue`
    lazy var startOFWeekValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `independentValue`
    lazy var independentValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `unMemberCheckValue`
    lazy var unMemberCheckValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `bordersValue`
    lazy var bordersValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `landlockedCheckValue`
    lazy var landlockedCheckValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `latlngValue`
    lazy var latlngValue: UILabel = {
        itemValueLabel()
    }()
    
    /// `Body Stack View`
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            listHStackView(itemTitleLabel(text: SConstants.flag.localize()), countryFlagValue),
            listHStackView(itemTitleLabel(text: SConstants.countryName.localize()), countryNameValue),
            listHStackView(itemTitleLabel(text: SConstants.capitalCity.localize()), capitalNameValue),
            listHStackView(itemTitleLabel(text: SConstants.continentName.localize()), continentNameValue),
            listHStackView(itemTitleLabel(text: SConstants.timeZone.localize()), timeZoneValue),
            listHStackView(itemTitleLabel(text: SConstants.population.localize()), populationValue),
            listHStackView(itemTitleLabel(text: SConstants.currencyName.localize()), currencyNameValue),
            listHStackView(itemTitleLabel(text: SConstants.currencySign.localize()), currencySignValue),
            listHStackView(itemTitleLabel(text: SConstants.startOfWeek.localize()), startOFWeekValue),
            listHStackView(itemTitleLabel(text: SConstants.independent.localize()), independentValue),
            listHStackView(itemTitleLabel(text: SConstants.UNMember.localize()), unMemberCheckValue),
            listHStackView(itemTitleLabel(text: SConstants.landborders.localize()), bordersValue),
            listHStackView(itemTitleLabel(text: SConstants.landLocked.localize()), landlockedCheckValue),
            listHStackView(itemTitleLabel(text: SConstants.latLong.localize()), latlngValue)
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
