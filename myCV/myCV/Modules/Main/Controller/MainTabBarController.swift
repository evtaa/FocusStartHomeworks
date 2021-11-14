//
//  MainTabBarController.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
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
    private func createViewControllers () -> [UIViewController] {
        var controllers = [UIViewController]()
        
        let personalInfoViewController = PersonalInfoAssembler.assemble()
        let personalInfoNavigationController = UINavigationController(rootViewController: personalInfoViewController)
        personalInfoViewController.tabBarItem = UITabBarItem(title: AppText.Tabs.personalInfo, image: AppImages.Tabs.personalInfo , selectedImage: AppImages.Tabs.personalInfoSelect)
        personalInfoViewController.tabBarItem.tag = 0
        controllers.append(personalInfoNavigationController)
        
        let  profileController = ProfileAssembler.assemble()
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        profileController.tabBarItem = UITabBarItem(title: AppText.Tabs.profile, image: AppImages.Tabs.profile, selectedImage: AppImages.Tabs.profileSelect)
        profileController.tabBarItem.tag = 1
        controllers.append(profileNavigationController)
        
        let interestsController = InterestsAssembler.assemble()
        let interestsNavigationController = UINavigationController(rootViewController: interestsController)
        interestsController.tabBarItem = UITabBarItem(title: AppText.Tabs.interests, image: AppImages.Tabs.interests, selectedImage: AppImages.Tabs.interestsSelect)
        interestsController.tabBarItem.tag = 2
        controllers.append(interestsNavigationController)
        return controllers
    }
}
