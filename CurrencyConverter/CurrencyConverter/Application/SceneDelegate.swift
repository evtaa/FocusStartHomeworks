//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 21.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = AuthAssembler.assemble()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        { return }
        appDelegate.appContainer.coreDataService.saveContext()
    }


}

