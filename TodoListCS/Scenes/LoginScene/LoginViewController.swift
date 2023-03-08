//
//  LoginViewController.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

final class LoginViewController: UIViewController {
	
	@IBOutlet var loginTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	
	var interactor: ILoginInteractor?
	
//	private var router: ILoginRouter?
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
	
	@IBAction func loginButtonPressed(_ sender: UIButton) {
		if let email = loginTextField.text, let password = passwordTextField.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
	}
}

extension LoginViewController: ILoginViewController {
	func render(viewModel: LoginModels.ViewModel) {
		if viewModel.success {
			// router
			
			print("OKK")
		} else {
			let	alert = UIAlertController(
				title: "Error",
				message: "Login or Password is incorrect",
				preferredStyle: UIAlertController.Style.alert
			)
//			let action = UIAlertAction(title: "Ok", style: .default)
			let action = UIAlertAction(title: "OK", style: .default) { _ in
				self.passwordTextField.text = ""
			}
			alert.addAction(action)
			present(alert, animated: true)
		}
	}
}

