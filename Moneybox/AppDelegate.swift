//
//  AppDelegate.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import UIKit
import Hopoate
import Router

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        registerDependencies()
        window?.rootViewController = configureRootViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func configureRootViewController() -> UIViewController {
        let rootController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: rootController)
        let router = AppRouter(rootViewController: navigationController)
        register(router, for: Router.self)
        return navigationController
    }
    
    func registerDependencies() {
        register(OAuthService(tokenContext: TokenContext()), for: Authorising.self)
        let userManager = UserManager()
        register(userManager, for: UserManaging.self)
    }


}

private func authService() -> Authorising {
    let context = TokenContext()
    let auth = OAuthService(tokenContext: context)
    return auth
}
