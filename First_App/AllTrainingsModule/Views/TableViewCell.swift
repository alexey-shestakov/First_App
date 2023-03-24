//
//  WorkoutTableViewCell.swift
//  First_App
//
//  Created by Alexey Shestakov on 28.02.2023.
//

import UIKit

class AllWorkoutsTableViewCell: UITableViewCell {
    
//    weak var workoutCellDelegate: AllTrainingsTableView?
    
    static let idTableViewCell = "idTableViewCell"
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "biceps")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialBlack
        label.font = .interBold22()
        label.text = "Push ups"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let workoutRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 2"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialGreen
        label.font = .robotoBold16()
        label.text = "15.03.2023"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var labelsStackView: UIStackView = UIStackView()
    
    //MARK: - Сохранили модель, по данным которой формируется ячейка
    private var workoutModel = WorkoutModel()       // Изначально модель для каждой ячейки дефолтная

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        self.addSubview(backgroundCell)
        self.addSubview(workoutBackgroundView)
        self.addSubview(dateLabel)
        
        workoutBackgroundView.addSubview(workoutImageView)
        self.addSubview(workoutNameLabel)
        
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel],
                                      axis: .horizontal,
                                      spacing: 10)

        
        self.addSubview(labelsStackView)
    }
    
    
    public func configure(model: WorkoutModel) {
        workoutNameLabel.text = model.workoutName
        workoutRepsLabel.text = "Reps: \(model.workoutReps)"
        workoutSetsLabel.text = "Sets: \(model.workoutSets)"
        dateLabel.text = "\(model.workoutDate.dayMonthYearString())"
        guard let imageData = model.workoutImage,
              let image = UIImage(data: imageData) else {return}
        workoutImageView.image = image.withRenderingMode(.alwaysTemplate)
        
    }
    
    
}


extension AllWorkoutsTableViewCell {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),    // self - к самой ячейке
            backgroundCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70),
            workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),

            workoutImageView.centerYAnchor.constraint(equalTo: workoutBackgroundView.centerYAnchor),
            workoutImageView.centerXAnchor.constraint(equalTo: workoutBackgroundView.centerXAnchor),
            workoutImageView.widthAnchor.constraint(equalToConstant: 60),
            workoutImageView.heightAnchor.constraint(equalToConstant: 60),

            workoutNameLabel.centerYAnchor.constraint(equalTo: workoutBackgroundView.centerYAnchor, constant: -10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            workoutNameLabel.heightAnchor.constraint(equalToConstant: 25),

            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            labelsStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
    }
}
