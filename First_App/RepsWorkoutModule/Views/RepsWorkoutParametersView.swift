//
//  InformationExerciseView.swift
//  MyFirstApp
//
//  Created by Мой Macbook on 09.03.2023.
//

import UIKit

protocol NextSetProtocol: AnyObject {
    func nextSet()
    func editingStatred()
}

class RepsWorkoutParametersView: UIView {
    
    weak var repsVC: NextSetProtocol?
    
    private let workoutNameLabel = UILabel(text: "Biceps", font: .robotoMedium24(), textColor: .specialGray, textAligment: .center)
    
    private let setsLabel = UILabel(text: "Sets", font: .robotoMedium18(), textColor: .specialGray, textAligment: .left)
    
    private let numberOfSetsLabel = UILabel(text: "1/4", font: .robotoMedium24(), textColor: .specialGray, textAligment: .center)
    
    private var setsStackView = UIStackView()
    private let customSeparatorFirst: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repsLabel = UILabel(text: "Reps", font: .robotoMedium18(), textColor: .specialGray, textAligment: .left)
    
    private let numberOfRepsLabel = UILabel(text: "20", font: .robotoMedium24(), textColor: .specialGray, textAligment: .center)
    
    private var repsStackView = UIStackView()
    private let customSeparatorSecond: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialBrown
        button.tintColor = .specialLine
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.setImage(UIImage(named: "editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .specialLightBrown
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT SET", for: .normal)
        button.backgroundColor = .specialYellow
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .specialGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(workoutNameLabel)
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        setsStackView.distribution = .equalSpacing
        addSubview(setsStackView)
        addSubview(customSeparatorFirst)
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        repsStackView.distribution = .equalSpacing
        addSubview(repsStackView)
        addSubview(customSeparatorSecond)
        addSubview(editingButton)
        addSubview(nextButton)
    }
    
    
    @objc private func editingButtonTapped() {
        repsVC?.editingStatred()
    }
    
    @objc private func nextButtonTapped() {
        repsVC?.nextSet()
    }
    
    public func refreshLabels(model: WorkoutModel, numberOfSets: Int) {
        workoutNameLabel.text = "\(model.workoutName)"
        numberOfSetsLabel.text = "\(numberOfSets)/\(model.workoutSets)"
        numberOfRepsLabel.text = "\(model.workoutReps)"
    }
}
extension RepsWorkoutParametersView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            workoutNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            customSeparatorFirst.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 0),
            customSeparatorFirst.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            customSeparatorFirst.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            customSeparatorFirst.heightAnchor.constraint(equalToConstant: 1),
            
            repsStackView.topAnchor.constraint(equalTo: customSeparatorFirst.bottomAnchor, constant: 30),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            customSeparatorSecond.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 0),
            customSeparatorSecond.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            customSeparatorSecond.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            customSeparatorSecond.heightAnchor.constraint(equalToConstant: 1),
            
            editingButton.topAnchor.constraint(equalTo: customSeparatorSecond.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            nextButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 15),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
}
