//
//  TitleLabel.swift
//  First_App
//
//  Created by Alexey Shestakov on 05.03.2023.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(textTitle: String, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = textTitle
        self.font = .robotoBold24()
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = textAlignment
        self.minimumScaleFactor = 0.8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleLabel {
    func setUpConstraints(atView: UIView) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: atView.centerXAnchor),
            self.topAnchor.constraint(equalTo: atView.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
}
