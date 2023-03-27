//
//  CastomAlert.swift
//  First_App
//
//  Created by Alexey Shestakov on 27.03.2023.
//

import UIKit

class CastomAlert {
    
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view                         //тамик не вырубаем, так как все делаем на фреймах
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
//    private scrollView = UIScrollView()
    
    
}
