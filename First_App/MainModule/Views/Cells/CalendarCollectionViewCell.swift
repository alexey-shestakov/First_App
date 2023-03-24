//
//  CallendarCollectionViewCell.swift
//  First_App
//
//  Created by Alexey Shestakov on 26.02.2023.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "We"
        label.font = .robotoBold16()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.text = "22"
        label.font = .robotoBold20()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.backgroundColor = .specialYellow
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                self.backgroundColor = .specialGreen
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpViews() {
        layer.cornerRadius = 10
        
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
    }
    
    public func dateForCell(numberOfDay: String, dayOfWeek: String) {
        dayOfWeekLabel.text = dayOfWeek
        numberOfDayLabel.text = numberOfDay
    }
}

extension CalendarCollectionViewCell {
    private func setUpConstrints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            
            numberOfDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        
        ])
    }
}
