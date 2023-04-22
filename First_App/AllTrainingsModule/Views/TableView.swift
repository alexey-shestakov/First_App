

import UIKit

protocol AllWorkoutsTableViewProtocol: AnyObject {
    func deleteModel(model: WorkoutModel)
}

class AllWorkoutsTableView: UITableView {
    
    weak var tableDelegate: AllWorkoutsTableViewProtocol?
    
    var allWorkouts = RealmManager.shared.getResultWorkoutModel().sorted{$0.workoutDate > $1.workoutDate}
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        setDelegated()
        configure()
        register(AllWorkoutsTableViewCell.self, forCellReuseIdentifier: AllWorkoutsTableViewCell.idTableViewCell)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegated() {
        delegate = self
        dataSource = self
    }
    
    private func configure() {
        backgroundColor = .none
        separatorStyle = .none  // Разделитель между ячейками
        showsVerticalScrollIndicator = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension AllWorkoutsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: AllWorkoutsTableViewCell.idTableViewCell, for: indexPath) as? AllWorkoutsTableViewCell else {return UITableViewCell()}
        
        cell.configure(model: allWorkouts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") {  [weak self] _, _, _ in
            guard let modelDelete = self?.allWorkouts[indexPath.row] else {return}
            self?.tableDelegate?.deleteModel(model: modelDelete)
            self?.allWorkouts = RealmManager.shared.getResultWorkoutModel().sorted{$0.workoutDate > $1.workoutDate}
            self?.reloadData()
        }
        action.backgroundColor = .specialBackground  // Action как бы вьюха
        action.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [action])
    }
}
extension AllWorkoutsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
