//
//  LoginInteractor.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

final class LoginInteractor: ILoginInteractor {
	var presenter: ILoginPresenter?
	private var worker: ILoginWorker
	
	init(presenter: ILoginPresenter, worker: ILoginWorker) {
		self.presenter = presenter
		self.worker = worker
	}
	
	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		
		let response = LoginModels.Response(
			success: result.success == 1,
			login: result.login,
			lastLoginDate: result.lastLoginDate
		)
		
		presenter?.present(responce: response)
	}
}

