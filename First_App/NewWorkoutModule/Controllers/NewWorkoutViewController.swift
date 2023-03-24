//
//  NewWorkoutViewController.swift
//  First_App
//
//  Created by Alexey Shestakov on 05.03.2023.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    weak var delegate: MainViewController?
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private lazy var scrollView = NewWorkoutScrollView(contentViewWidth: view.frame.width,
                                                       contentViewHeight: view.frame.height)

    private var workoutModel = WorkoutModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setUpViews()
        setUpConstrints()
        addGesture()
    }
    
    
    private func setUpViews() {
        self.view.addSubview(textField)
        self.view.addSubview(scrollView)
        
        self.scrollView.closeButton.clouser = { [weak self] in
            self?.closeButtonTapped()
        }

        self.scrollView.saveButton.clouser = { [weak self] in
            self?.save()
        }
    }
    
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    
    //MARK: SAVE func
    @objc private func save() {
        setModel()
        saveModel()
        
    }
    
    //MARK: SET MODEL
    private func setModel() {
        workoutModel.workoutName = scrollView.nameView.getTextFromTextField().split(separator: " ").joined(separator: " ")

        workoutModel.workoutDate = scrollView.dateAndRepeat.getDateAndRepeat().date.onlyDate()
        workoutModel.workoutRepeat = scrollView.dateAndRepeat.getDateAndRepeat().isRepeat
        workoutModel.workoutNumberOfDay = scrollView.dateAndRepeat.getDateAndRepeat().date.getNumberOfDay()

        workoutModel.workoutSets = scrollView.repsOrTimer.sets
        workoutModel.workoutReps = scrollView.repsOrTimer.reps
        workoutModel.workoutTimer = scrollView.repsOrTimer.timer

        workoutModel.workoutImageName = scrollView.imageWorkout.selectedImage

        let workoutImage = UIImage(named: scrollView.imageWorkout.selectedImage)
        guard let imageData = workoutImage?.pngData() else {return}
        workoutModel.workoutImage = imageData
    }
    
    
//     Сначала собираем содель потом (делаем проверки) сохраняем и обновляем
    private func saveModel() {
        let text  = workoutModel.workoutName
        let count = text.filter {$0.isNumber || $0.isLetter }.count

        if count != 0 && workoutModel.workoutSets != 0 &&
            (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(workoutModel)
            workoutModel = WorkoutModel()
            dismiss(animated: true)
            delegate?.workoutViewController = nil
        } else {
            presentSimpleAlert(title: "Error", message: "Enter proper parameters")
        }
    }

    
    private func addGesture() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)

        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        print("new workout done")
    }
}




//MARK: Constraints
extension NewWorkoutViewController {
    private func setUpConstrints() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 30),
            
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
