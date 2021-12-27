//
//  SceneDelegate.swift
//  ImageNetworkService
//
//  Created by Alexandr Evtodiy on 09.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = ListImagesAssembler.assemble()
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}

