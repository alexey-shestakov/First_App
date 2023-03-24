//
//  WorkoutModel.swift
//  First_App
//
//  Created by Alexey Shestakov on 11.03.2023.
//
import Foundation
import RealmSwift

class WorkoutModel: Object {
    @Persisted var workoutDate: Date = Date()
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutName: String = "Unknown"
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int
    @Persisted var workoutReps: Int
    @Persisted var workoutTimer: Int  //в секундах
    @Persisted var workoutImage: Data?  //картинка может быть, а может и не быть
    @Persisted var workoutImageName: String
    @Persisted var status: Bool = false
}

