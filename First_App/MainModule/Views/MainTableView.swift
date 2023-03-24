//
//  MainTableView.swift
//  First_App
//
//  Created by Alexey Shestakov on 28.02.2023.
//

import UIKit

protocol MainTableViewProtocol: AnyObject {
    func deleteWorkout(model: WorkoutModel, index: Int)
}

class MainTableView: UITableView {
    
    weak var mainVC: MainViewController?    //
    
    weak var mainDelegate: MainTableViewProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
        setDelegates()
        register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.idTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        separatorStyle = .none  // Разделитель между ячейками
        showsVerticalScrollIndicator = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setDelegates() {
        delegate = self
        dataSource = self
    }
}

// MARK: UITableViewDataSource
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainVC = mainVC else {return 0}
        return mainVC.workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.idTableViewCell, for: indexPath) as? WorkoutTableViewCell,
              let model = mainVC?.workoutArray[indexPath.row] else {return UITableViewCell()}

        cell.configure(model: model)
        cell.workoutCellDelegate = mainDelegate as? WorkoutCellProtocol
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, _ in
            guard let workoutArray = self?.mainVC?.workoutArray else {return}
            let deletemodel = workoutArray[indexPath.row]
            self?.mainDelegate?.deleteWorkout(model: deletemodel, index: indexPath.row)
        }
        
        action.backgroundColor = .specialBackground  // Action как бы вьюха
        action.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [action])
    }
}
    

// MARK: UITableViewDelegate
extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

