//
//  AppDelegate.swift
//  NewsTest
//
//  Created by AnhLe on 10/05/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    var launchCoordinator = AppCoordinator()
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let window = self.window {
            launchCoordinator.setRoot(for: window)
        }
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        return true
    }

}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            NewsRepository() as NewsUseCase
        }
        register {
        }.scope(.application)
    }
}
