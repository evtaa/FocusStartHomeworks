//
//  SceneDelegate.swift
//  myCV
//
//  Created by Alexandr Evtodiy on 10.11.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = MainAssembler.assemble()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

