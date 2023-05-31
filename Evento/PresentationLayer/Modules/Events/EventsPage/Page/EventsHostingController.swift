//
//  EventsHostingController.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import SwiftUI

final class EventsHostingController: UIHostingController<EventsPage> {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.searchTextField.rightView = filterButton
        return searchBar
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.filter.resize(to: CGSize(width: 28, height: 28)), for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Images.bellWithBadge, for: .normal)
        button.addTarget(self, action: #selector(bellButtonTapped), for: .touchUpInside)
        return button
    }()
    private let viewModel: EventsViewModel
    
    init(viewModel: EventsViewModel) {
        self.viewModel = viewModel
        super.init(rootView: EventsPage(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
}

extension EventsHostingController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.searchTextField.rightViewMode = .never
        navigationItem.rightBarButtonItem = nil
    }
        
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.searchTextField.rightViewMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bellButton)
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

private extension EventsHostingController {
    func setup() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let custCgColor = CustColor.purple.cgColor ?? UIColor.purple.cgColor
        navigationController?.navigationBar.tintColor = UIColor(cgColor: custCgColor)
        
        // Set the search bar as the title view of the navigation controller
        navigationItem.titleView = searchBar
        
        // For showing filter button
        searchBar.searchTextField.rightViewMode = .always
        
        // Set the bell button as the right navigation bar button item of the navigation controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bellButton)
    }
    
    @objc func filterButtonTapped() {
        viewModel.didTapFilter?()
    }
    
    @objc func bellButtonTapped() {
        // Handle bell button tapped
    }
}
