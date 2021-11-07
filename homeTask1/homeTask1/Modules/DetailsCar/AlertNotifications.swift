//
//  AlertNotifications.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 07.11.2021.
//

import Foundation
import UIKit

protocol AlertNotificationsProtocol: ShowAlert  {
    var controller: DetailsCarViewController? {get set}
    func  showFailedCarManufacturer ()
    func  showFailedCarModel ()
    func  showFailedInputNumberCarYearOfIssue ()
    func  showFailedCountOfNumberCarYearOfIssue ()
}

class AlertNotifications: NSObject, AlertNotificationsProtocol {
    
    // MARK: - Properties
    weak var controller: DetailsCarViewController?
    
    // MARK: - ShowAlert
    internal func  showFailedCarManufacturer () {
        guard let controller = controller else {return}
        showAlert(forViewController: controller,
                  withTitleOfAlert: Text.notification,
                  andMessage: Text.failedCarManufacturer,
                  withTitleOfAction: Text.ok,
                  handlerOfAction: nil)
    }
    
    internal func  showFailedCarModel () {
        guard let controller = controller else {return}
        showAlert(forViewController: controller,
                  withTitleOfAlert: Text.notification,
                  andMessage: Text.failedCarModel,
                  withTitleOfAction: Text.ok,
                  handlerOfAction: nil)
    }
    
    internal func  showFailedInputNumberCarYearOfIssue () {
        guard let controller = controller else {return}
        showAlert(forViewController: controller,
                  withTitleOfAlert: Text.notification,
                  andMessage: Text.failedInputNumberCarYearOfIssue,
                  withTitleOfAction: Text.ok,
                  handlerOfAction: nil)
    }
    
    internal func  showFailedCountOfNumberCarYearOfIssue () {
        guard let controller = controller else {return}
        showAlert(forViewController: controller,
                  withTitleOfAlert: Text.notification,
                  andMessage: Text.failedCountOfNumberCarYearOfIssue,
                  withTitleOfAction: Text.ok,
                  handlerOfAction: nil)
    }
}
