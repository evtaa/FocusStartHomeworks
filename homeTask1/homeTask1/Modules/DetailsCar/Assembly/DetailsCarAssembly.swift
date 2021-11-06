//
//  DetailsCarAssembly.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 31.10.2021.
//

import UIKit

final class DetailsCarAssembly {
    static func vc() -> DetailsCarViewController {
        var alertNotifications: AlertNotificationsProtocol = AlertNotifications()
        let vc = DetailsCarViewController(alertNotifications: alertNotifications)
        alertNotifications.controller = vc
        return vc
    }
}
