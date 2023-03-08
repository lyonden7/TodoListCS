//
//  ModuleBuilder.swift
//  TodoListCS
//
//  Created by Денис Васильев on 07.03.2023.
//

import UIKit

/// Протокол, описывающий сборку экранов.
protocol IModuleBuilder {
	/// Метод для сборки экрана Main.
	/// - Returns: Готовый экран MainViewController.
	static func createMainModule() -> UIViewController
}

// MARK: - ModuleBuilder
/// Класс, реализующий протокол для сборки экранов.
final class ModuleBuilder: IModuleBuilder {
	/// Метод, создающий MainViewController со всеми зависимостями.
	/// - Returns: MainViewController.
	static func createMainModule() -> UIViewController {
//		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//		guard let view = storyboard.instantiateViewController(withIdentifier: "MainViewController")
//				as? MainViewController
//		else {
//			fatalError("На Main.storyboard нет MainViewController!")
//		}
		let view = MainViewController()
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		let sections = SectionForTaskManagerAdapter(taskManager: taskManager)
		let worker: IMainWorker = MainWorker(sectionManager: sections)
		
		let presenter = MainPresenter(
			view: view,
			sectionManager: sections
		)
		
		let interactor = MainInteractor(
			presenter: presenter,
			sectionManager: sections,
			worker: worker
		)
		
		view.interactor = interactor
		interactor.presenter = presenter
		presenter.view = view
		
		taskManager.addTasks(tasks: repository.getTasks())
		
		return view
	}
	
	/// Метод, создающий LoginViewController со всеми зависимостями.
	/// - Returns: LoginViewController.
	static func createLoginModule() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

		guard let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
				as? LoginViewController
		else {
			fatalError("На Main.storyboard нет MainViewController!")
		}

		let worker: ILoginWorker = LoginWorker()
//		let router = LoginRouter()
				
		
		let presenter = LoginPresenter(view: view)
		let interactor = LoginInteractor(presenter: presenter, worker: worker)
		
		view.interactor = interactor
		interactor.presenter = presenter
		presenter.view = view
//		router.viewController = view
		
		return view
	}
}
