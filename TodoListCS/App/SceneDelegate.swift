//
//  SceneDelegate.swift
//  TodoListCS
//
//  Created by Денис Васильев on 22.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		
		let mainVC = ModuleBuilder.createMainModule()
		let navigationController = UINavigationController(rootViewController: mainVC)
//		let loginVC = ModuleBuilder.createLoginModule()
//		let navigationController = UINavigationController(rootViewController: loginVC)
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}




