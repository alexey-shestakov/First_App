//
//  StartWorkoutViewController.swift
//  MyFirstApp
//
//

import UIKit

class TimerWorkoutViewController: UIViewController {
   
    private let startWorkoutLabel = TitleLabel(text: "START WORKOUT",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray,
                                            textAligment: .center)
    
    private lazy var closeButton = CloseButton()
    private let imageSportsman: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sportsman")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let ditailsLabel = UILabel(textLightBrown: "Ditails")
    private let informationExerciseView = TimerWorkoutParametersView()
    private lazy var finishButton = GreenButton(text: "FINISH")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(imageSportsman)
        view.addSubview(ditailsLabel)
        view.addSubview(informationExerciseView)
        view.addSubview(finishButton)
        
    }
    
    
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

extension TimerWorkoutViewController {
    private func setConstrains() {
        
        startWorkoutLabel.setUpConstraints(atView: view)
        closeButton.setUpConstraints(atView: view, atOneYWith: startWorkoutLabel)
        
        NSLayoutConstraint.activate([
            
            imageSportsman.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            imageSportsman.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageSportsman.heightAnchor.constraint(equalToConstant: 240),
            
            ditailsLabel.topAnchor.constraint(equalTo: imageSportsman.bottomAnchor, constant: 20),
            ditailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            informationExerciseView.topAnchor.constraint(equalTo: ditailsLabel.bottomAnchor, constant: 5),
            informationExerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationExerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            informationExerciseView.heightAnchor.constraint(equalToConstant: 250),
            
            finishButton.topAnchor.constraint(equalTo: informationExerciseView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
