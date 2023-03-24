//
//  CalendarView.swift
//  First_App
//
//  Created by Alexey Shestakov on 21.02.2023.
//

import UIKit

class CalendarView: UIView {
    
    private let collectionView = CalendarCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        self.backgroundColor = .specialGreen
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(collectionView)
    }
    
    public func setDelegate(delegate: CalendarCollectionViewProtocol) {
        collectionView.mainVCdelegate = delegate
    }
}

extension CalendarView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105)
        ])
    }
}
