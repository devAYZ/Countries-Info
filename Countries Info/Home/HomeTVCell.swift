//
//  HomeTVCell.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

final class HomeTVCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 40, height: 40)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            countryLabel, cityLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .right
        label.text = "$"
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "chevron.forward")
        imageView.contentMode = .center
        imageView.anchor(width: 24, height: 16)
        imageView.clipsToBounds = true
        imageView.tintColor = .label
        return imageView
    }()

    lazy var bodyStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView, labelStack,
            currencyLabel, arrowImageView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupLayout() {
        contentView.addSubview(bodyStack)
        bodyStack.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         paddingRight: 10)
    }
    
    func setupCell(_ data: CountriesResponse?) {
        countryLabel.text = data?.name?.common ?? .orNA
        cityLabel.text = data?.capital?.first ?? .orNA
        currencyLabel.text = data?.currencies?.first?.value.symbol ?? .orNA
        iconImageView.loadImage(from: data?.flags?.png)
    }
}
