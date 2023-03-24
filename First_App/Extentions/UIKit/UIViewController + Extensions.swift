//
//  UIViewController + extensions.swift
//  First_App
//
//  Created by Alexey Shestakov on 14.03.2023.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)

    }
    
}
