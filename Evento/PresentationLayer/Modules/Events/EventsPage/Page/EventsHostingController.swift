//
//  EventsHostingController.swift
//  Evento
//
//  Created by Ramir Amrayev on 01.05.2023.
//

import SwiftUI

final class EventsHostingController: UIHostingController<EventsPage> {
    
    let searchBar = UISearchBar()
    let filterButton = UIButton(type: .system)
    let bellButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Set up the search bar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        // Set up the filter button
        filterButton.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        // Set up the bell button
        bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
        bellButton.addTarget(self, action: #selector(bellButtonTapped), for: .touchUpInside)
        
        // Set the search bar as the title view of the navigation controller
        navigationItem.titleView = searchBar
        
        // Set the filter button as the right navigation bar button item of the search bar
        searchBar.searchTextField.rightView = filterButton
        searchBar.searchTextField.rightViewMode = .always
        
        // Set the bell button as the right navigation bar button item of the navigation controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bellButton)
    }
    
    @objc private func filterButtonTapped() {
        // Handle filter button tapped
    }
    
    @objc private func bellButtonTapped() {
        // Handle bell button tapped
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
