//
//  LoginPresenter.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

protocol ILoginPresenter {
	func present(responce: LoginModels.Response)
}

final class LoginPresenter: ILoginPresenter {
	weak var view: ILoginViewController?
	
	init(view: ILoginViewController?) {
		self.view = view
	}
	
	func present(responce: LoginModels.Response) {
		let viewModel = LoginModels.ViewModel(
			success: responce.success,
			userName: responce.login,
			lastLoginDate: "\(responce.lastLoginDate)"
		)
		
		view?.render(viewModel: viewModel)
	}
}

