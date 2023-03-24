//
//  CloseButton.swift
//  First_App
//
//  Created by Alexey Shestakov on 05.03.2023.
//

import UIKit

class CloseButton: UIButton {
    
    var clouser: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.layer.cornerRadius = 15
        self.backgroundColor = .specialGray
        self.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        self.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func closeButtonTapped() {
        clouser?()
    }
}

extension CloseButton {
    func setUpConstraints(atView: UIView, atOneYWith: UIView) {
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: atOneYWith.centerYAnchor),
            self.trailingAnchor.constraint(equalTo: atView.trailingAnchor, constant: -20),
            self.widthAnchor.constraint(equalToConstant: 30),
            self.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
