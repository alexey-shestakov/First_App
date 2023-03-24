//
//  ImageCollectionView.swift
//  First_App
//
//  Created by Alexey Shestakov on 12.03.2023.
//

import UIKit

class ImageCollectionView: UICollectionView {
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    weak var referanceTo: ImageWorkoutView?
    
    private let imageArray: [WorkoutImages] = [.biceps, .chest, .kettlebell, .defaultIm]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        setUpLayout()
        setDelegates()
        register(ImageWorkoutCell.self, forCellWithReuseIdentifier: ImageWorkoutCell.idWorkoutImageCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .specialBrown
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.showsHorizontalScrollIndicator = false
    }
    
    private func setUpLayout() {
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}

extension ImageCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageWorkoutCell.idWorkoutImageCell, for: indexPath) as? ImageWorkoutCell else {return UICollectionViewCell()}
        let imageString = imageArray[indexPath.item].rawValue
        cell.workoutImageView.image = UIImage(named: imageString)?.withRenderingMode(.alwaysTemplate)
        if indexPath.item == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            referanceTo?.selectedImage = "\(imageArray[indexPath.item].rawValue)"
        }
        
        return cell
    }
}

extension ImageCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5,
               height: collectionView.frame.height)
    }
}

extension ImageCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        referanceTo?.selectedImage = "\(imageArray[indexPath.item].rawValue)"
        
    }
}
