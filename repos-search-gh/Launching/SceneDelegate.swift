//
//  SceneDelegate.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard
            let windowScene = (scene as? UIWindowScene)
        else {
            return
        }
        let testViewReactor = TestViewReactor()
        let testVC = TestViewController(reactor: testViewReactor)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = testVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
