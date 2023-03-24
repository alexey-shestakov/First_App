//
//  GreenButton.swift
//  First_App
//
//  Created by Alexey Shestakov on 06.03.2023.
//

import UIKit

class GreenButton: UIButton {
    
    var clouser: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.backgroundColor = .specialGreen
        self.titleLabel?.font = .robotoBold16()
        self.tintColor = .white
        self.layer.cornerRadius = 10
        self.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func closeButtonTapped() {
        clouser?()
    }
}
