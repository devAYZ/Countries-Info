//
//  HomeTVCell.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import UIKit

class HomeTVCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.text = "Ayokunle Emmanuel"
        return label
    }()

    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    lazy var bodyStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            labelStack
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
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
}
