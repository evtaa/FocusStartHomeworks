//
//  ListCarsTableViewDelegate.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 06.11.2021.
//

import Foundation
import UIKit

extension ListCarsViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shownCars = shownCars else {
            return 0
        }
        return shownCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(ofType: ListCarsTableViewCell.self, for: indexPath)
        guard let car = shownCars?[indexPath.row] else {
            return dequeueCell
        }
        let viewModelCar = CarViewModelFactory.cellModel(from: car )
        dequeueCell.configure(with: viewModelCar)
        return dequeueCell
    }
}

extension ListCarsViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


