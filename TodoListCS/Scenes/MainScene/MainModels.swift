//
//  MainModels.swift
//  TodoListCS
//
//  Created by Денис Васильев on 08.03.2023.
//

import Foundation

/// Перечисление моделей VIP цикла MainScene.
enum MainModels {
	/// Структура для передачи данных из MainViewController в MainInteractor.
	struct Request {
		/// Индекс ячейки.
		let indexPath: IndexPath
	}
	
	/// Структура для передачи данных из MainInteractor в MainPresenter.
	struct Response {
		struct Section {
			/// Название секции.
			let title: String
			/// Массив задач.
			let tasks: [Task]
		}
		
		let tasksBySection: [Section]
	}
	
	/// Структура для передачи данных из MainPresenter в MainViewController.
	struct ViewModel {
		struct RegularTask {
			/// Название задачи
			let name: String
			/// Статус выполнения задачи.
			let isDone: Bool
		}
		
		struct ImportantTask {
			/// Название задачи.
			let name: String
			/// Статус выполнения задачи.
			let isDone: Bool
			/// Просрочена ли задача.
			let isOverDue: Bool
			/// Дедлайн задачи.
			let deadLine: String
			/// Приоритет задачи.
			let priority: String
		}
		
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			/// Название секции.
			let title: String
			/// Массив задач.
			let tasks: [Task]
		}
		
		let tasksBySection: [Section]
	}
}
