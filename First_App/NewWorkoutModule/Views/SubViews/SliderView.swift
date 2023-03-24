//
//  SliderView.swift
//  First_App
//
//  Created by Alexey Shestakov on 08.03.2023.
//

import UIKit

protocol SliderViewProtocol: AnyObject {
    func changeValue(sliderType: SliderType, value: Int)
}

class SliderView: UIView {
    
    weak var delegate: SliderViewProtocol?
    
    private let slider = GreenSlider()
    
    private var sliderType: SliderType?
    
    private let nameLabel = UILabel(text: "some", font: .robotoMedium18(), textColor: .specialBlack, textAligment: .left)
    private let numberLabel = UILabel(text: "0", font: .robotoMedium24(), textColor: .specialBlack, textAligment: .right)
    
    private var superStack = UIStackView()
    
    public var isActive: Bool = true {
        didSet {
            if self.isActive {
                self.alpha = 1
            } else {
                self.alpha = 0.5
                slider.value = 0
                numberLabel.text = "0"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
    }
    
    convenience init(name: String, minValue: Float, maxValue: Float, type: SliderType) {
        self.init(frame: .zero)
        nameLabel.text = name
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        sliderType = type

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        let stackUpper = UIStackView(arrangedSubviews: [nameLabel, numberLabel],
                                 axis: .horizontal,
                                 spacing: 0)
        stackUpper.distribution = .equalCentering

        superStack = UIStackView(arrangedSubviews: [stackUpper, slider],
                                 axis: .vertical,
                                 spacing: 15)
        self.addSubview(superStack)
        
        self.slider.addTarget(self, action: #selector(sliderChanged), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func sliderChanged() {
        let intSliderValue = Int(slider.value)
        numberLabel.text = sliderType == .timer ? intSliderValue.getTimeFromsSeconds() : "\(intSliderValue)"
        guard let sliderType = sliderType else {return}
        delegate?.changeValue(sliderType: sliderType, value: intSliderValue)
    }
}





//MARK: - Set Constraints

extension SliderView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            superStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            superStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            superStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            superStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
