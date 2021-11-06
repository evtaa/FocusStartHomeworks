//
//  BaseViewController.swift
//  homeTask1
//
//  Created by Alexandr Evtodiy on 27.10.2021.
//

import UIKit

class BaseViewController<ViewType: UIView>: UIViewController {
    var rootView: ViewType {
        self.view as? ViewType ?? ViewType()
    }
    
    override func loadView() {
        self.view = ViewType()
    }
}
