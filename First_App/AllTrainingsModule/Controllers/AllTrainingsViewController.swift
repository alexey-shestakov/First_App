//
//  AllTrainingsViewController.swift
//  First_App
//
//  Created by Alexey Shestakov on 23.03.2023.
//

import UIKit

class AllTrainingsViewController: UIViewController {
    
    private let titleLabel = TitleLabel(textTitle: "ALL WORKOUTS", textColor: .specialBlack, textAlignment: .center)
    
    let closeButton = CloseButton()
    
    private var tableView = AllWorkoutsTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        view.backgroundColor = .specialBackground
    }
    
    
    private func setUpViews() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(tableView)
        tableView.tableDelegate = self
        closeButton.clouser = { [weak self] in
            self?.closeButtonTapped()
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

extension AllTrainingsViewController: AllWorkoutsTableViewProtocol {
    func deleteModel(model: WorkoutModel) {
        RealmManager.shared.deleteTraining(model: model)
    }
}

extension AllTrainingsViewController {
    private func setUpConstraints() {
        
        titleLabel.setUpConstraints(atView: self.view)
        closeButton.setUpConstraints(atView: self.view, atOneYWith: titleLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
