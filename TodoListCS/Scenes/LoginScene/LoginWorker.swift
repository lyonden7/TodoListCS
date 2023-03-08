//
//  LoginWorker.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

public struct LoginDTO {
	var success: Int
	var login: String
	var lastLoginDate: Date
}

protocol ILoginWorker {
	func login(login: String, password: String) -> LoginDTO
}

final class LoginWorker: ILoginWorker {
	func login(login: String, password: String) -> LoginDTO {
//		if login == "Admin" && password == "pa$$32!" {
		if login == "123" && password == "123" {
			return LoginDTO(
				success: 1,
				login: login,
				lastLoginDate: Date()
			)
		} else {
			return LoginDTO(
				success: 0,
				login: login,
				lastLoginDate: Date()
			)
		}
	}
}
