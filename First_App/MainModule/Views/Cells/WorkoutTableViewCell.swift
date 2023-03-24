//
//  WorkoutTableViewCell.swift
//  First_App
//
//  Created by Alexey Shestakov on 28.02.2023.
//

import UIKit

protocol WorkoutCellProtocol: AnyObject {
    func startButtonTapped(model: WorkoutModel)
}

class WorkoutTableViewCell: UITableViewCell {
    
    weak var workoutCellDelegate: WorkoutCellProtocol?
    
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
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
//        button.backgroundColor = .specialYellow
        button.titleLabel?.font = .robotoBold16()
//        button.setTitle("START", for: .normal)
//        button.tintColor = .specialDarkGreen
        button.addTarget(self, action: #selector(startButttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isComplete: Bool {
        didSet {
            if self.isComplete {
                startButton.setTitle("COMPLETE", for: .normal)
                startButton.tintColor = .white
                startButton.backgroundColor = .specialGreen
                startButton.isEnabled = false       // Чтобы пользователь второй раз не нажал (доступна или нет)
            } else {
                startButton.setTitle("START", for: .normal)
                startButton.tintColor = .specialDarkGreen
                startButton.backgroundColor = .specialYellow
                startButton.isEnabled = true        // Доступна для нажатия
            }
        }
    }
    
    private var labelsStackView: UIStackView = UIStackView()
    
    //MARK: - Сохранили модель, по данным которой формируется ячейка
    private var workoutModel = WorkoutModel()       // Изначально модель для каждой ячейки дефолтная

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.isComplete = false
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
        
        workoutBackgroundView.addSubview(workoutImageView)
        self.addSubview(workoutNameLabel)
        
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel],
                                      axis: .horizontal,
                                      spacing: 10)

        
        self.addSubview(labelsStackView)
        contentView.addSubview(startButton) // Если что-то делаем с ячейкой (добавляем кнопку, слайдер), то добавляем на contentView, а не просто в ячейку\
    }
    
    
    @objc private func startButttonTapped() {
        isComplete = true
        workoutCellDelegate?.startButtonTapped(model: workoutModel)
        
    }
    
    public func configure(model: WorkoutModel) {       // Конфигурируем ячейку на основании пришедшей модели
        
        workoutModel = model // Когда приходит модель мы ее записываем для каждой ячейки
        
        workoutNameLabel.text = workoutModel.workoutName
        if model.workoutTimer == 0 {
            workoutRepsLabel.text = "Reps: \(workoutModel.workoutReps)"
        } else {
            workoutRepsLabel.text = "Timer: \(workoutModel.workoutTimer.getTimeFromsSeconds())"
        }
        workoutSetsLabel.text = "Sets: \(workoutModel.workoutSets)"
        
        if workoutModel.status {
            isComplete = true
        } else {
            isComplete = false
        }
        
        // Проверяем, есть ли изображение и можем ли мы из него получить картинку
        guard let imageData = workoutModel.workoutImage,
              let image = UIImage(data: imageData) else {return}
        workoutImageView.image = image.withRenderingMode(.alwaysTemplate)
        
    }
}


extension WorkoutTableViewCell {
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

            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -5),

            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 5),
            labelsStackView.centerYAnchor.constraint(equalTo: workoutBackgroundView.centerYAnchor, constant: -5),
            labelsStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            labelsStackView.heightAnchor.constraint(equalToConstant: 16),

            startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30),
        
        ])
    }
}
