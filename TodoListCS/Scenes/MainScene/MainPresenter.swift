//
//  MainPresenter.swift
//  TodoListCS
//
//  Created by Денис Васильев on 07.03.2023.
//

import Foundation

/// Протокол, описывающий MainPresenter.
protocol IMainPresenter {
	/// Метод, подготавливающий данные для отображения на экране.
	/// - Parameter response: Структура для передачи данных из MainInteractor в MainPresenter.
	func mapViewData(with response: MainModels.Response)
}

/// Класс, реализующий MainPresenter.
final class MainPresenter: IMainPresenter {
	weak var view: IMainViewController!
	
	private let sectionManager: ISectionForTaskManagerAdapter!
	
	init(view: IMainViewController, sectionManager: ISectionForTaskManagerAdapter!) {
		self.view = view
		self.sectionManager = sectionManager
	}
	
	func mapViewData(with response: MainModels.Response) {
		var sections: [MainModels.ViewModel.Section] = []
		for section in sectionManager.getSections() {
			let sectionData = MainModels.ViewModel.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionManager.getTasksForSection(section: section))
			)
			
			sections.append(sectionData)
		}
		
		let viewModel = MainModels.ViewModel(tasksBySection: sections)
		view.render(viewModel: viewModel)
	}
	
	private func mapTasksData(tasks: [Task]) -> [MainModels.ViewModel.Task] {
		tasks.map { mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> MainModels.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = MainModels.ViewModel.ImportantTask(
				name: task.title,
				isDone: task.isCompleted,
				isOverDue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			
			return .importantTask(result)
		} else {
			return .regularTask(MainModels.ViewModel.RegularTask(name: task.title, isDone: task.isCompleted))
		}
	}
}
