//
//  NameWorkout.swift
//  First_App
//
//  Created by Alexey Shestakov on 06.03.2023.
//

import UIKit

class NameView: UIView {
    
    private let nameLabel = UILabel(textLightBrown: "Name")
    
    private let textField = BrownTextField()
    
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
        self.addSubview(textField)
    }
    
    public func getTextFromTextField() -> String {
        guard let text = self.textField.text else {return ""}
        return text
    }
}

extension NameView {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            textField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


extension NameView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}
