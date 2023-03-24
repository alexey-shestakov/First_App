//
//  RepsOrTimerView.swift
//  First_App
//
//  Created by Alexey Shestakov on 06.03.2023.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let nameLabel = UILabel(textLightBrown: "Reps or timer view")
    
    private let backgroundView = UIView(backGroundColor: .specialBrown, cornerRadius: 10)
    
    private let setsSlider = SliderView(name: "Sets", minValue: 0, maxValue: 10, type: .sets)
    private let orLabel = UILabel(textLightBrown: "Choose repeat or timer")
    private let repsSlider = SliderView(name: "Reps", minValue: 0, maxValue: 50, type: .reps)
    private let timerSlider = SliderView(name: "Timer", minValue: 0, maxValue: 600, type: .timer)
    
    private var stack = UIStackView()
    
    public var (sets, reps, timer) = (0, 0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.orLabel.textAlignment = .center
        stack = UIStackView(arrangedSubviews: [setsSlider, orLabel, repsSlider, timerSlider],
                            axis: .vertical,
                            spacing: 20)
        self.addSubview(nameLabel)
        self.addSubview(backgroundView)
        self.addSubview(stack)
    }
    
    private func setDelegates() {
        setsSlider.delegate = self
        repsSlider.delegate = self
        timerSlider.delegate = self
    }
}


extension RepsOrTimerView: SliderViewProtocol{
    func changeValue(sliderType: SliderType, value: Int) {
        switch sliderType {
        case .sets:
            sets = value
        case .reps:
            reps = value
            repsSlider.isActive = true
            timerSlider.isActive = false
            timer = 0
        case .timer:
            timer = value
            timerSlider.isActive = true
            repsSlider.isActive = false
            reps = 0
        }
    }
}

extension RepsOrTimerView {
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
            
            stack.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -10)
        ])
    }
}
