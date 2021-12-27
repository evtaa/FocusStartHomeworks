//
//  ListImagesSearchControllerDataHandler.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 10.12.2021.
//

import UIKit

protocol IListImagesSearchControllerDataHandler: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    var searchButtonClickedHandler: ((_ text: String) -> Void)? { get set }
}

final class ListImagesSearchControllerDataHandler: NSObject {

    //MARK: - Handlers
    var searchButtonClickedHandler: ((_ text: String) -> Void)?
}

// MARK: - UITableViewDelegate
extension ListImagesSearchControllerDataHandler: IListImagesSearchControllerDataHandler {
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text
        else { return }
        searchButtonClickedHandler?(text)
    }
}
