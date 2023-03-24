//
//  StatisticsTableViewCell.swift
//  First_App
//
//  Created by Alexey Shestakov on 02.03.2023.
//

import UIKit

class StatisticsTabelCell: UITableViewCell {
    
    weak var tableDelegate: StatisticsTabel?
    
    private let exersiseTitle = TitleLabel(textTitle: "Biceps", textColor: .specialBlack, textAlignment: .left)
    
    private let repsBefore = UILabel(textLightBrown: "Before: 18")
    
    private let repsNow = UILabel(textLightBrown: "Now: 18")
    
    private var stack = UIStackView()
    
    private let repsProgress = TitleLabel(textTitle: "+2", textColor: .specialGreen, textAlignment: .right)
    
    private let onePointView = UIView(backGroundColor: .specialLine, cornerRadius: 0)
    
    static let idCellTabel = "idCellTabel"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .gray
        self.addSubview(exersiseTitle)
        self.addSubview(repsProgress)
        stack = UIStackView(arrangedSubviews: [repsBefore, repsNow],
                            axis: .horizontal,
                            spacing: 10)
        self.addSubview(stack)
        self.addSubview(onePointView)
    }
    
    //MARK: - Configuration
    public func configure(index: Int, delegate: StatisticsTabel) {
        self.tableDelegate = delegate
        self.exersiseTitle.text = tableDelegate?.arrayModels.map{$0.workoutName}[index]
        
        guard let lastTrainingReps = tableDelegate?.arrayReps[index].last else {return}
        
        if let previousTrainingReps = tableDelegate?.arrayReps[index].suffix(2).first {
            let difference = lastTrainingReps - previousTrainingReps
            repsBefore.text = "Before: \(previousTrainingReps)"
            repsNow.text = "Now: \(lastTrainingReps)"
            repsProgress.text = "\(difference)"
        }
    }
    
}

extension StatisticsTabelCell {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            exersiseTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            exersiseTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            exersiseTitle.trailingAnchor.constraint(equalTo: repsProgress.trailingAnchor),
            
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stack.heightAnchor.constraint(equalToConstant: 20),
            
            repsProgress.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            repsProgress.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            onePointView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            onePointView.heightAnchor.constraint(equalToConstant: 1),
            onePointView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            onePointView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
            
        ])
    }
}
