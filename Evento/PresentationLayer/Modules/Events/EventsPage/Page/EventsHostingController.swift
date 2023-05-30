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
        
        // Set up the search bar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
                
        // Set up the filter button
        filterButton.setImage(Images.filter.resize(to: CGSize(width: 28, height: 28)), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        // Set up the bell button
        bellButton.setImage(Images.bellWithBadge, for: .normal)
        bellButton.addTarget(self, action: #selector(bellButtonTapped), for: .touchUpInside)
        
        // Set the search bar as the title view of the navigation controller
        navigationItem.titleView = searchBar
        
        // Set the filter button as the right navigation bar button item of the search bar
        searchBar.searchTextField.rightView = filterButton
        searchBar.searchTextField.rightViewMode = .always
        
        // Set the bell button as the right navigation bar button item of the navigation controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bellButton)
    }
    
    @objc func filterButtonTapped() {
        // Handle filter button tapped
    }
    
    @objc func bellButtonTapped() {
        // Handle bell button tapped
    }
}
