//
//  GreenSlider.swift
//  First_App
//
//  Created by Alexey Shestakov on 08.03.2023.
//

import UIKit

class GreenSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.maximumTrackTintColor = .specialLightBrown
        self.minimumTrackTintColor = .specialGreen
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
