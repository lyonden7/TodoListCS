//
//  ITaskManager.swift
//  TodoListCS
//
//  Created by Денис Васильев on 07.03.2023.
//

import Foundation

/// Протокол для TaskManager.
protocol ITaskManager {
	/// Метод, возвращающий все задачи.
	/// - Returns: Список задач.
	func getAllTasks() -> [Task]
	
	/// Метод, возвращающий выполненные задачи.
	/// - Returns: Список задач.
	func getCompletedTasks() -> [Task]
	
	/// Метод, возвращающий невыполненные задачи.
	/// - Returns: Список задач.
	func getUncompletedTasks() -> [Task]
	
	/// Метод для добавления списка задач в список.
	/// - Parameter tasks: Список задач.
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager { }

extension ImportantTask.TaskPriority: CustomStringConvertible {
	var description: String {
		switch self {
		case .low:
			return "!"
		case .medium:
			return "!!"
		case .high:
			return "!!!"
		}
	}
}
