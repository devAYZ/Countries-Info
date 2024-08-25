//
//  HomeViews.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

final class HomeViews: UIView {

    // MARK: Views
    lazy var countryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTVCell.self, forCellReuseIdentifier: "\(HomeTVCell.self)")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .systemGreen
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.font = .systemFont(ofSize: 16, weight: .medium)
        searchBar.placeholder = SConstants.searchHint
        return searchBar
    }()
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton()
        button.anchor(width: 35, height: 35)
        button.setImage(.init(named: "side-menu-icon"), for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = SConstants.favCountriesList
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
        stackView.spacing = -20
        return stackView
    }()
    
    /// `Empty View`
    private lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "Sweden-transparent")
        imageView.contentMode = .center
        imageView.alpha = .pointOne
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = SConstants.dataNA
        return label
    }()
    
    lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle(SConstants.tryAgain, for: .normal)
        button.backgroundColor = .systemRed.withAlphaComponent(0.7)
        button.layer.cornerRadius = 5
        button.anchor(width: 140, height: 40)
        button.titleLabel?.font = .boldSystemFont(ofSize: 21)
        return button
    }()
    
    lazy var emptyInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emptyLabel, tryAgainButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.backgroundColor = .systemBackground
        view.style = .large
        view.color = .systemGreen
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
        
        emptyView.addSubviews(emptyImageView, emptyInfoStack)
        
        setupLayout()
    }

    private func setupLayout() {
        emptyImageView.anchor(top: emptyView.topAnchor,
                              left: emptyView.leftAnchor,
                              bottom: emptyView.bottomAnchor,
                              right: emptyView.rightAnchor)
        emptyInfoStack.center(inView: emptyView, yConstant: -80)
    }

}
