//
//  LoginModels.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

/// Перечисление моделей VIP цикла LoginScene.
enum LoginModels {
	/// Структура модели для передачи данных из LoginViewController в LoginInteractor.
	struct Request {
		var login: String
		var password: String
	}
	
	/// Структура модели для передачи данных из LoginInteractor в LoginPresenter.
	struct Response {
		var success: Bool
		var login: String
		var lastLoginDate: Date
	}
	
	/// Структура модели для передачи данных из LoginPresenter в LoginViewController.
	struct ViewModel {
		var success: Bool
		var userName: String
		var lastLoginDate: String
	}
}
