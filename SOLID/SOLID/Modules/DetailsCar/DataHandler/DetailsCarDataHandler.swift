//
//  DetailsCarDataHandler.swift
//  SOLID
//
//  Created by Alexandr Evtodiy on 06.12.2021.
//

import UIKit

protocol IDetailsCarDataHandler: UITableViewDataSource, UITableViewDelegate {
    var radioButtonTouchUpInsideHandler: ((_ typeOfBody: TypeOfBody) -> Void)? { get set }
    
    func setTypesOfBody(typesOfBody: [TypeOfBody])
}

final class DetailsCarDataHandler: NSObject {
    
    //MARK: - Properties
    private var typesOfBody: [TypeOfBody]?
    
    //MARK: - Handlers
    var radioButtonTouchUpInsideHandler: ((_ typeOfBody: TypeOfBody) -> Void)?
}

// MARK: - UITableViewDataSource
extension DetailsCarDataHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count =  typesOfBody?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let typeOfBody = typesOfBody?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(ofType: DetailsCarCell.self, for: indexPath) as IDetailsCarCell
        cell.setTypeOfBody(typeOfBody: typeOfBody)
        cell.configure(with: TableDetailsCarViewModelFactory.getViewModel(from: typeOfBody))
        cell.radioButtonTouchUpInsideHandler = { [weak self] typeOfBody in
            if let typesOfBody = self?.typesOfBody,
               let index = typesOfBody.firstIndex(where: { (type) -> Bool in
                typeOfBody == type
               }) {
                self?.typesOfBody = typesOfBody.enumerated().map({ (indexOfType, type) -> TypeOfBody in
                    if indexOfType == index {
                        return type.createTypeOfBodyWithToggleIsEnabled()
                    } else {
                        return type.createTypeOfBodyWithFalseIsEnabled()
                    }
                })
            }
            self?.radioButtonTouchUpInsideHandler?(typeOfBody)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DetailsCarDataHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterCell(ofType: DetailsCarHeaderView.self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension DetailsCarDataHandler: IDetailsCarDataHandler  {
    func setTypesOfBody(typesOfBody: [TypeOfBody]) {
        self.typesOfBody = typesOfBody
    }
}
