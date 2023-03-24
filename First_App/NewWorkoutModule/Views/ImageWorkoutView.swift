//
//  ImageWorkoutView.swift
//  First_App
//
//  Created by Alexey Shestakov on 12.03.2023.
//

import UIKit

class ImageWorkoutView: UIView {
    
    private let nameLabel = UILabel(textLightBrown: "Workout Image")
    
    private let collectionView = ImageCollectionView()
    
    
    
    
    public var selectedImage: String = WorkoutImages.defaultIm.rawValue
    
    public var workoutImage = UIImage(named: WorkoutImages.defaultIm.rawValue)
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUpViews()
        setUpConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.addSubview(nameLabel)
        self.addSubview(collectionView)
    }
    
    private func setDelegates() {
        collectionView.referanceTo = self
    }
    
}

extension ImageWorkoutView {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
