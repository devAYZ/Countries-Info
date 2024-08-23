//
//  SideMenuTVCell.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//

import UIKit

class SideMenuTVCell: UITableViewCell {

    private lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(width: 40, height: 40)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            menuLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    lazy var bodyStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            menuImageView, labelStack
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
    
    func setupCell(list: SideMenuList) {
        menuLabel.text = list.menuTitle
        menuImageView.image = list.menuImage
    }

}
