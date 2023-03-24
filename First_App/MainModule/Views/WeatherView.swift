//
//  WeatherView.swift
//  First_App
//
//  Created by Alexey Shestakov on 21.02.2023.
//

import UIKit

class WeatherView: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpViews()
        setConstaints()
    }
    
    private let imageViewWeather: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelWeather: UILabel = {
        let label = UILabel()
        label.text = "Солнечно"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDiscription: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, идем на улицу!!!"
        label.textColor = .specialGray
        label.font = .robotoMedium14()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
        self.addShadowOnView()
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageViewWeather)
        self.addSubview(labelWeather)
        self.addSubview(labelDiscription)
    }
}

extension WeatherView {
    private func setConstaints() {
        NSLayoutConstraint.activate([
            imageViewWeather.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageViewWeather.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageViewWeather.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            imageViewWeather.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            labelWeather.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            labelWeather.trailingAnchor.constraint(equalTo: imageViewWeather.leadingAnchor, constant: -5),
            labelWeather.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            labelDiscription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            labelDiscription.trailingAnchor.constraint(equalTo: imageViewWeather.leadingAnchor, constant: -5),
            labelDiscription.topAnchor.constraint(equalTo: labelWeather.bottomAnchor, constant: 0),
            labelDiscription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)

        ])
    }
}
