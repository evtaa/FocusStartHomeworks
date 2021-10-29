//
//  ListCarsModuleBuilder.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 29.10.2021.
//

import UIKit

final class ListCarsModuleBuilder {
    static func build() -> UINavigationController {
        let vc = ListCarsViewController()
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
