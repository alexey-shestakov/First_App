//
//  RealmManager.swift
//  First_App
//
//  Created by Alexey Shestakov on 11.03.2023.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init() {}
    
    let realm = try! Realm()
    
    func saveWorkoutModel(_ model: WorkoutModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func getResultWorkoutModel() -> Results<WorkoutModel> {
        return self.realm.objects(WorkoutModel.self)
    }
    
    func deleteTraining(model: WorkoutModel) {
        // В реалме для удаления требуется передавать конкретную модель (которую удаляем), по индексу сделать не получится!
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func changeWorkoutSetsReps(model: WorkoutModel, reps: Int, sets: Int) {
        try! realm.write {
            model.workoutReps = reps
            model.workoutSets = sets
        }
    }
    
    func makeWorkoutDone(model: WorkoutModel, status: Bool) {
        try! realm.write {
            model.status = status
        }
    }
}

