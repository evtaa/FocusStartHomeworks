//
//  RatesTableViewDataHandler.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import UIKit

protocol IRatesTableViewDataHandler: UITableViewDataSource, UITableViewDelegate {
    func set(arrayOfRate: [Rate])
    func set(baseRate: Rate)
}

final class RatesTableViewDataHandler: NSObject {
    
    //MARK: - Properties
    private var arrayOfRate: [Rate]?
    private var baseRate: Rate?
}

// MARK: - UITableViewDataSource
extension RatesTableViewDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  arrayOfRate?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rate = arrayOfRate?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(ofType: RatesCell.self, for: indexPath) as IRatesCell

        cell.configure(with: RatesRateViewModelFactory.createRateViewModel(rate: rate))
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension RatesTableViewDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterCell(ofType: RatesHeaderView.self)
        guard let baseRate = baseRate
        else { return UIView()}
        headerView.configure(with: RatesBaseRateViewModelFactory.createBaseRateViewModel(baseRate: baseRate))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension RatesTableViewDataHandler: IRatesTableViewDataHandler  {
    func set(arrayOfRate: [Rate]) {
        self.arrayOfRate = arrayOfRate
    }
    
    func set(baseRate: Rate) {
        self.baseRate = baseRate
    }
}

