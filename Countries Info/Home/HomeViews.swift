//
//  HomeViews.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

class HomeViews: UIView {

    // MARK: Views
    lazy var countryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTVCell.self, forCellReuseIdentifier: "\(HomeTVCell.self)")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton()
        button.anchor(width: 30, height: 30)
        button.setImage(.init(named: "side-menu-icon"), for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.text = "Favourite Countries List"
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    lazy var headerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            sideMenuButton, topLabel
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    /// `Empty View`
    
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
