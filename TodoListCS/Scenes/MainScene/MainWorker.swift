//
//  MainWorker.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

/// Протокол, описывающий MainWorker.
protocol IMainWorker {
	/// Метод, возвращающий структуру для передачи данных из MainInteractor в MainPresenter.
	/// - Returns: Структура для передачи данных из MainInteractor в MainPresenter.
	func getSections() -> MainModels.Response
}

final class MainWorker: IMainWorker {
	private let sectionManager: ISectionForTaskManagerAdapter!
	
	init(sectionManager: ISectionForTaskManagerAdapter!) {
		self.sectionManager = sectionManager
	}
	
	func getSections() -> MainModels.Response {
		var sections: [MainModels.Response.Section] = []
		for section in sectionManager.getSections() {
			let sectionData = MainModels.Response.Section(
				title: section.title,
				tasks: sectionManager.getTasksForSection(section: section)
			)
			
			sections.append(sectionData)
		}
		
		return MainModels.Response(tasksBySection: sections)
	}
}
