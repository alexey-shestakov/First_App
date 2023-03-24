//
//  Int + extensions.swift
//  First_App
//
//  Created by Alexey Shestakov on 10.03.2023.
//

import Foundation

extension Int {
    
    func getTimeFromsSeconds() -> String {
        if self / 60 == 0 {
            return "\(self % 60) sec"
        }
        
        if self % 60 == 0 {
            return "\(self / 60) min"
        }
        
        return "\(self / 60) min \(self % 60) sec"
    }
    
}
