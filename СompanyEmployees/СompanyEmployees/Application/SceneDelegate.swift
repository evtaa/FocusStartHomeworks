//
//  SceneDelegate.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 14.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coreDataManager: ICoreDataManager?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let coreDataManager = CoreDataManager()
        self.coreDataManager = coreDataManager
        let vc = ListCompanyAssembler.assemble(companyStorage: coreDataManager )
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        coreDataManager?.saveContext()
    }
}

