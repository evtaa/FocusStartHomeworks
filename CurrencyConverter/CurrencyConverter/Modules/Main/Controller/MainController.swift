//
//  MainController.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 26.12.2021.
//

import Foundation

import UIKit

final class MainController: UITabBarController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = createViewControllers()
        configureTabBar()
    }

    // MARK: - Configure
    private func configureTabBar () {
        self.selectedIndex = 0
    }
    
    // MARK: - Private functions
    private func createViewControllers () -> [UIViewController]? {
        var controllers = [UIViewController]()
        
        guard let convertorViewController = ConverterAssembler.assemble()
        else { return nil }
        let convertorNavigationController = UINavigationController(rootViewController: convertorViewController)
        convertorViewController.tabBarItem = UITabBarItem(title: AppText.Tabs.convertor, image: AppImages.Tabs.convertor , selectedImage: AppImages.Tabs.convertorSelect)
        convertorViewController.tabBarItem.tag = 0
        controllers.append(convertorNavigationController)
        
        guard let listCurrencyController = ListCurrencyAssembler.assemble()
        else { return nil }
        let listCurrencyNavigationController = UINavigationController(rootViewController: listCurrencyController)
        listCurrencyController.tabBarItem = UITabBarItem(title: AppText.Tabs.listCurrency, image: AppImages.Tabs.listCurrency, selectedImage: AppImages.Tabs.listCurrencySelect)
        listCurrencyController.tabBarItem.tag = 1
        controllers.append(listCurrencyNavigationController)
        return controllers
    }
}
