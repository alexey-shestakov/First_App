//
//  StartWorkoutViewController.swift
//  MyFirstApp
//
//

import UIKit

class RepsWorkoutViewController: UIViewController {
<<<<<<< HEAD
    //
=======
>>>>>>> 23b94f7bc2cba1158d0a33f1391593db223da03b
   
    private let startWorkoutLabel = TitleLabel(text: "START WORKOUT",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray,
                                            textAligment: .center)
    
    private lazy var closeButton = CloseButton()
    private let imageSportsman: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sportsman")
        image.contentMode = .scaleAspectFit     // чтобы картинка норм вошла
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let ditailsLabel = UILabel(textLightBrown: "Ditails")
    private let informationExerciseView = RepsWorkoutParametersView()
    private lazy var finishButton = GreenButton(text: "FINISH")
    
<<<<<<< HEAD
    private var numberOfSet = 1 {
        didSet {
            informationExerciseView.refreshLabels(model: workoutModel, numberOfSets: numberOfSet)
        }
    }
    
=======
>>>>>>> 23b94f7bc2cba1158d0a33f1391593db223da03b
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
<<<<<<< HEAD
        setDelegates()
=======
>>>>>>> 23b94f7bc2cba1158d0a33f1391593db223da03b
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(imageSportsman)
        view.addSubview(ditailsLabel)
        view.addSubview(informationExerciseView)
        view.addSubview(finishButton)
        
        closeButton.clouser = { [weak self] in
            self?.closeButtonTapped()
        }
        
        finishButton.clouser = { [weak self] in
            self?.finishButtonTabbed()
        }
    }
    
<<<<<<< HEAD
    private func setDelegates() {
        informationExerciseView.repsVC = self
    }
    
=======
>>>>>>> 23b94f7bc2cba1158d0a33f1391593db223da03b
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTabbed() {
<<<<<<< HEAD
        RealmManager.shared.makeWorkoutDone(model: workoutModel, status: true)
        dismiss(animated: true)
        print(workoutModel)
    }
    
    public func setModel(model: WorkoutModel) {
        self.workoutModel = model
        informationExerciseView.refreshLabels(model: model, numberOfSets: numberOfSet)
    }
    
    private var workoutModel = WorkoutModel() {
        didSet{
            print("modified")
        }
    }
}

extension RepsWorkoutViewController: NextSetProtocol {
    func nextSet() {
        guard numberOfSet != workoutModel.workoutSets else {
            RealmManager.shared.makeWorkoutDone(model: workoutModel, status: true)
            return dismiss(animated: true)
        }
        numberOfSet += 1
    }
    
    func editingStatred() {
        RealmManager.shared.changeWorkoutSetsReps(model: workoutModel, reps: workoutModel.workoutReps - 1, sets: workoutModel.workoutSets - 1)
        informationExerciseView.refreshLabels(model: workoutModel, numberOfSets: numberOfSet)
        
    }
=======
        print("Finish")
    }
    
>>>>>>> 23b94f7bc2cba1158d0a33f1391593db223da03b
}

extension RepsWorkoutViewController {
    private func setConstrains() {
        
        startWorkoutLabel.setUpConstraints(atView: view)
        closeButton.setUpConstraints(atView: view, atOneYWith: startWorkoutLabel)
        
        NSLayoutConstraint.activate([
            
            imageSportsman.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 30),
            imageSportsman.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageSportsman.heightAnchor.constraint(equalToConstant: 240),
            
            ditailsLabel.topAnchor.constraint(equalTo: imageSportsman.bottomAnchor, constant: 20),
            ditailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            informationExerciseView.topAnchor.constraint(equalTo: ditailsLabel.bottomAnchor, constant: 5),
            informationExerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationExerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            informationExerciseView.heightAnchor.constraint(equalToConstant: 250),
            
            finishButton.topAnchor.constraint(equalTo: informationExerciseView.bottomAnchor, constant: 40),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
