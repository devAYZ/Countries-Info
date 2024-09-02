//
//  HomeViews.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import UIKit

final class HomeViews: UIView {

    // MARK: Views
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        
        // Customizing the font for placeholder
        let searchTextField = search.searchBar.value(forKey: "searchField") as? UITextField
        
        // Set the font for the placeholder text
        let placeholderFont: [NSAttributedString.Key: UIFont] = [
            .font: .italicSystemFont(ofSize: 15)]
        searchTextField?.attributedPlaceholder = NSAttributedString(
            string: SConstants.searchHint,
            attributes: placeholderFont)
        return search
    }()
    
    lazy var sideMenuButton: UIButton = {
        let button = UIButton()
        button.anchor(width: 35, height: 35)
        button.setImage(.init(named: "side-menu-icon"), for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        button.layer.cornerRadius = 5
        return button
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
        
        containerView.addSubviews(countryTableView)
        
        containerView.addSubviews(
            countryTableView,
            emptyView,
            loader)
        
        startLoader(true)
        
        countryTableView.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor,
            paddingLeft: 5,
            paddingRight: 5)
        
        emptyView.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor)
        
        loader.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: containerView.rightAnchor)
        
        setupLayout()
    }

    private func setupLayout() {
        emptyImageView.anchor(top: emptyView.topAnchor,
                              left: emptyView.leftAnchor,
                              bottom: emptyView.bottomAnchor,
                              right: emptyView.rightAnchor)
        emptyInfoStack.center(inView: emptyView)
    }
    
    
    func startLoader(_ state: Bool) {
        switch state {
        case true:
            loader.isHidden = !state
            loader.startAnimating()
        case false:
            loader.isHidden = !state
            loader.stopAnimating()
        }
    }

}
