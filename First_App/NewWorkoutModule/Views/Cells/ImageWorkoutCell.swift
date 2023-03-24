//
//  ImageWorkoutCell.swift
//  First_App
//
//  Created by Alexey Shestakov on 11.03.2023.
//

import UIKit

class ImageWorkoutCell: UICollectionViewCell {
    
    static let idWorkoutImageCell = "idWorkoutImageCell"
    
    private let workoutImageBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .specialBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let workoutImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit                         // Сжимает либо увеличивает картинку
        image.image = UIImage(named: "default")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                workoutImageBackground.backgroundColor = .specialGreen
                workoutImageView.tintColor = .white
            } else {
                workoutImageBackground.backgroundColor = .specialBackground
                workoutImageView.tintColor = .black
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUpViews()
        setUpConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.layer.cornerRadius = 10
        
        self.addSubview(workoutImageBackground)
        workoutImageBackground.addSubview(workoutImageView)
    }
}

extension ImageWorkoutCell {
    private func setUpConstaints() {
        NSLayoutConstraint.activate([
            workoutImageBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            workoutImageBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            workoutImageBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            workoutImageBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            workoutImageView.topAnchor.constraint(equalTo: workoutImageBackground.topAnchor),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutImageBackground.leadingAnchor),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutImageBackground.trailingAnchor),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutImageBackground.bottomAnchor),
            
            
        ])
    }
}
