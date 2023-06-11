//
//  SearchHostingController.swift
//  Evento
//
//  Created by RAmrayev on 10.06.2023.
//

import Foundation
import SwiftUI
import Combine

final class SearchHostingController: UIHostingController<SearchPage> {
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(rootView: SearchPage(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
}

extension SearchHostingController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.searchTextField.rightViewMode = .never
        navigationItem.rightBarButtonItem = nil
    }
        
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.searchTextField.rightViewMode = .always
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

private extension SearchHostingController {
    func setup() {
//        navigationController?.navigationBar.prefersLargeTitles = true
        let custCgColor = CustColor.purple.cgColor ?? UIColor.purple.cgColor
        navigationController?.navigationBar.tintColor = UIColor(cgColor: custCgColor)
        navigationController?.navigationBar.backgroundColor = .white
        // Set the search bar as the title view of the navigation controller
//        navigationItem.titleView = searchBar
        
        // For showing filter button
//        searchBar.searchTextField.rightViewMode = .always
        
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var searchText: String

        init(searchText: Binding<String>) {
            _searchText = searchText
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.searchText = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(searchText: $searchText)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }
}
