//
//  BrownTextField.swift
//  First_App
//
//  Created by Alexey Shestakov on 06.03.2023.
//

import UIKit

class BrownTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
//        delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .specialBrown
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 10
        self.textColor = .specialGray
        self.font = .robotoBold20()
        
        self.leftView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "pointer")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .specialGreen
            return imageView
        }()
        self.leftViewMode = .always
        self.clearButtonMode = .always
        self.returnKeyType = .done
    }
}


// MARK: - UITextFieldDelegate

//extension BrownTextField: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//    }
//}
