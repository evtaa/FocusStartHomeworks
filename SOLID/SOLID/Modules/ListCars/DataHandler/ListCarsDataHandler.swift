//
//  DataHandler.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 05.12.2021.
//

import UIKit

protocol IListCarsDataHandler: UITableViewDataSource, UITableViewDelegate {
    func setCars(cars: [Car])
    var selectButtonTouchUpInsideHandler: ((_ id: UUID) -> Void)? { get set }
}

final class ListCarsDataHandler: NSObject {
    
    //MARK: - Properties
    private var cars: [Car]?
    
    //MARK: - Handlers
    var selectButtonTouchUpInsideHandler: ((_ id: UUID) -> Void)?
}

// MARK: - UITableViewDataSource
extension ListCarsDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  cars?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let car = cars?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(ofType: ListCarsCell.self, for: indexPath) as IListCarsCell
        cell.setColorForMarkView(indexPath.row % 2 == 0 ?
                                    AppColors.ListCars.Cell.markViewColorOdd  :
                                    AppColors.ListCars.Cell.markViewEvenColor )
        cell.setIdOfCar(id: car.id)
        cell.configure(with: ListCarsViewModelFactory.getViewModel(from: car))
        cell.selectButtonTouchUpInsideHandler = { [weak self] id in
            self?.selectButtonTouchUpInsideHandler?(id)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCarsDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterCell(ofType: ListCarsHeaderView.self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ListCarsDataHandler: IListCarsDataHandler  {
    func setCars(cars: [Car]) {
        self.cars = cars
    }
}
