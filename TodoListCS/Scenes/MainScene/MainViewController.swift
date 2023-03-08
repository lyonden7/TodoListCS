//
//  MainViewController.swift
//  TodoListCS
//
//  Created by Денис Васильев on 07.03.2023.
//

import UIKit

/// Протокол, описывающий View.
protocol IMainViewController: AnyObject {
	/// Метод для отображения данных на экране.
	/// - Parameter viewData: Структура для передачи данных из MainPresenter в MainViewController.
	func render(viewModel: MainModels.ViewModel)
}

/// Контроллер, отображающий список выполненных и невыполненных задач.
final class MainViewController: UITableViewController {
	var interactor: IMainInteractor?
	
	private var viewModel: MainModels.ViewModel = MainModels.ViewModel(tasksBySection: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "ToDoList"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		interactor?.viewIsReady()
	}
}

//MARK: - UITableViewDataSource
extension MainViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySection.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.tasksBySection[section].title.uppercased()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksBySection[section]
		return section.tasks.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		let tasks = viewModel.tasksBySection[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		var contentConfiguration = cell.defaultContentConfiguration()
		
		switch taskData {
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText)
			taskText.append(NSAttributedString(string: task.name))
			
			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverDue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		}
		
		cell.tintColor = .systemBlue
		contentConfiguration.textProperties.font = UIFont.systemFont(ofSize: 19)
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		cell.contentConfiguration = contentConfiguration
		
		return cell
	}
}

// MARK: - UITableViewDelegate
extension MainViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(at: indexPath)
	}
}

// MARK: - IView
extension MainViewController: IMainViewController {
	func render(viewModel: MainModels.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
