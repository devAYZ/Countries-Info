//
//  SettingsViews.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

final class SettingsViews: UIView {
    
    // MARK: Views
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 70, height: 70)
        imageView.layer.cornerRadius = 35
        imageView.layer.borderColor = .init(
            red: .zero, green: 100, blue: .zero, alpha: 0.5)
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView, nameLabel, emailLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var signoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(SConstants.signOut.localize(), for: .normal)
        button.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.anchor(width: 200, height: 40)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return button
    }()
    
    lazy var bodyStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            infoStack, signoutButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 50
        return stackView
    }()

    
    lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
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
        
        setupLayout()
    }

    private func setupLayout() {}

}
