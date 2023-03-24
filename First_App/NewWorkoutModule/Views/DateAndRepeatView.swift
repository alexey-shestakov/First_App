//
//  DateAndRepeatView.swift
//  First_App
//
//  Created by Alexey Shestakov on 06.03.2023.
//

import UIKit

class DateAndRepeatView: UIView {
    
    private let nameLabel = UILabel(textLightBrown: "Date and repeat")
    
    private let backgroundView = UIView(backGroundColor: .specialBrown, cornerRadius: 10)
    
    private let datePicker: UIDatePicker = {
        let datePiker = UIDatePicker()
        datePiker.datePickerMode = .date
        datePiker.tintColor = .specialGreen
        datePiker.translatesAutoresizingMaskIntoConstraints = false
        return datePiker
    }()
    
    private let dateLabel = UILabel(text: "Date", font: .robotoMedium18(), textColor: .specialBlack, textAligment: .center)
    
    private let repeatEvery = UILabel(text: "Repeat every 7 days", font: .robotoMedium18(), textColor: .specialBlack, textAligment: .center)
    
    private lazy var repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = false
        repeatSwitch.onTintColor = .specialGreen
        repeatSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    private var stackUpper = UIStackView()
    
    private var stackLower = UIStackView()
    
    private var superStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameLabel)
        self.addSubview(backgroundView)

        stackUpper = UIStackView(arrangedSubviews: [dateLabel, datePicker],
                                 axis: .horizontal,
                                 spacing: 0)
        stackUpper.distribution = .equalSpacing
        
        stackLower = UIStackView(arrangedSubviews: [repeatEvery, repeatSwitch],
                                 axis: .horizontal,
                                 spacing: 0)
        stackLower.distribution = .equalSpacing
        
        superStack = UIStackView(arrangedSubviews: [stackUpper, stackLower],
                                 axis: .vertical,
                                 spacing: 10)
        self.addSubview(superStack)
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    
    public func getDateAndRepeat() -> (date: Date, isRepeat: Bool) {
        (datePicker.date, repeatSwitch.isOn)
    }
    
}

extension DateAndRepeatView {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            backgroundView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            superStack.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor),
            superStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            superStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
