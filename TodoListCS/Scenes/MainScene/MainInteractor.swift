//
//  MainInteractor.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

/// Протокол, описывающий MainInteractor.
protocol IMainInteractor {
	/// Метод,  в котором View сообщает Interactor, что она готова к работе.
	func viewIsReady()
	/// Метод,  в котором View сообщает Interactor, что пользователь выбрал задачу.
	/// - Parameter indexPath: Индекс выбранной ячейки.
	func didTaskSelected(at indexPath: IndexPath)
}

final class MainInteractor: IMainInteractor {
	var presenter: IMainPresenter?
	
	private let sectionManager: ISectionForTaskManagerAdapter!
	private let worker: IMainWorker!
	
	init(presenter: IMainPresenter, sectionManager: ISectionForTaskManagerAdapter, worker: IMainWorker) {
		self.presenter = presenter
		self.sectionManager = sectionManager
		self.worker = worker
	}
	
	func viewIsReady() {
		let section = worker.getSections()
		presenter?.mapViewData(with: section)
	}
	
	func didTaskSelected(at indexPath: IndexPath) {
		let section = worker.getSections()
		changeTaskStatus(at: indexPath)
		presenter?.mapViewData(with: section)
	}
	
	private func changeTaskStatus(at indexPath: IndexPath) {
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.isCompleted.toggle()
	}
}
