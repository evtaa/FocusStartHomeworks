//
//  ListCurrencyTableViewDataHandler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 25.12.2021.
//

import UIKit

protocol IListCurrencyTableViewDataHandler: UITableViewDataSource, UITableViewDelegate {
    var didSelectRowAtHandler: ((Symbol) -> Void)? { get set}
    
    func set(arrayOfSymbol: [Symbol])
}

final class ListCurrencyTableViewDataHandler: NSObject {
    
    //MARK: - Properties
    private var arrayOfSymbol: [Symbol]?
    
    // MARK: - Handlers
    var didSelectRowAtHandler: ((Symbol) -> Void)?
}

// MARK: - UITableViewDataSource
extension ListCurrencyTableViewDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  arrayOfSymbol?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let symbol = arrayOfSymbol?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(ofType: ListCurrencyCell.self, for: indexPath) as IListCurrencyCell

        cell.configure(with: ListCurrencySymbolViewModelFactory.createSymbolViewModel(symbol: symbol))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCurrencyTableViewDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterCell(ofType: ListCurrencyHeaderView.self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let symbol = arrayOfSymbol?[indexPath.row]
        else { return }
        didSelectRowAtHandler?(symbol)
    }
}

// MARK: - UITableViewDelegate
extension ListCurrencyTableViewDataHandler: IListCurrencyTableViewDataHandler  {
    func set(arrayOfSymbol: [Symbol]) {
        self.arrayOfSymbol = arrayOfSymbol
    }
}
