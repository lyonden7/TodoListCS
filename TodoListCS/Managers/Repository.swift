//
//  Repository.swift
//  TodoListCS
//
//  Created by Денис Васильев on 07.03.2023.
//

import Foundation

/// Протокол репозитория.
protocol ITaskRepository {
	/// Метод, возвращающий список задач из репозитория.
	/// - Returns: Список задач.
	func getTasks() -> [Task]
}

// MARK: - TaskRepositoryStub
/// Класс, реализующий протокол репозитория.
final class TaskRepositoryStub: ITaskRepository {
	func getTasks() -> [Task] {
		[
			ImportantTask(title: "Important task 1", taskPriority: .high),
			ImportantTask(title: "Important task 2", taskPriority: .medium),
			ImportantTask(title: "Important task 3", taskPriority: .low),
			RegularTask(title: "Regular task 1"),
			RegularTask(title: "Regular task 2", isCompleted: true)
		]
	}
}
