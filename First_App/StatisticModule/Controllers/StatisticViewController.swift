//
//  StatisticViewController.swift
//  First_App
//
//  Created by Alexey Shestakov on 02.03.2023.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let statisticLabel = TitleLabel(textTitle: "STATISTICS", textColor: .specialBlack, textAlignment: .center)
    
    private let excersiseLabel = UILabel(textLightBrown: "Excercises")
    
    private let tableHistory = StatisticsTabel()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont(name: "Roboto-Medium", size: 20)
        segmentedControl.setTitleTextAttributes([.font : font as Any,
                                                 .foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.font : font as Any,
                                                 .foregroundColor: UIColor.specialGray], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayData()
    }
    
    private func setUpViews() {
        self.view.backgroundColor = .specialBackground
        self.view.addSubview(statisticLabel)
        self.view.addSubview(excersiseLabel)
        self.view.addSubview(tableHistory)
        self.view.addSubview(segmentedControl)
    }
    

    
    @objc private func segmentedChange() {
        displayData()
    }
    
    private func displayData() {
        tableHistory.resetArrays()
        if segmentedControl.selectedSegmentIndex == 0 {
            tableHistory.countFromDate = Date().offsetDays(days: 7).onlyDate().localDate()
            getStatisticsWorkout(date: tableHistory.countFromDate)
        } else {
            tableHistory.countFromDate = Date().offsetMonths(months: 1).onlyDate().localDate()
            getStatisticsWorkout(date: tableHistory.countFromDate)
        }
        tableHistory.reloadData()
    }
    
    private func getStatisticsWorkout(date: Date) {
        var resultArrays = RealmManager.shared.getResultWorkoutModel()
        let date = tableHistory.countFromDate as NSDate
        
        let predicatePast = NSPredicate(format: "workoutDate > %@", date)
        let predicateFuture = NSPredicate(format: "workoutDate < %@", Date().onlyDate().localDate() as NSDate)
        
        let compound = NSCompoundPredicate(type: .and, subpredicates: [predicatePast, predicateFuture])
        
        resultArrays = resultArrays.filter(compound)
        
        for workout in resultArrays {
            if !tableHistory.arrayModels.map({$0.workoutName}).contains(workout.workoutName) {
                tableHistory.arrayModels.append(workout)
                tableHistory.arrayReps.append([workout.workoutReps])
                tableHistory.dateArray.append([workout.workoutDate])
            } else {
                for j in 0..<tableHistory.arrayModels.count {
                    if tableHistory.arrayModels[j].workoutName == workout.workoutName {
                        tableHistory.arrayReps[j].append(workout.workoutReps)
                        tableHistory.dateArray[j].append(workout.workoutDate)
                    }
                }
            }
        }   //лучше делать через словарь

        //Из-за того что тренировку можно добавить на старое число, то нкжно делать сортировку для reps и date
        for modelDatesIndex in 0..<tableHistory.dateArray.count {
            var modelDates = tableHistory.dateArray[modelDatesIndex].map{$0}
            var modelReps = tableHistory.arrayReps[modelDatesIndex].map{$0}
            for i in 0..<modelDates.count {
                for j in i+1..<modelDates.count {
                    if modelDates[j] < modelDates[i]{
                        let binDate = modelDates[i]
                        let binReps = modelReps[i]

                        modelDates[i] = modelDates[j]
                        modelDates[j] = binDate

                        modelReps[i] = modelReps[j]
                        modelReps[j] = binReps
                    }
                }
            }
            tableHistory.dateArray[modelDatesIndex] = modelDates
            tableHistory.arrayReps[modelDatesIndex] = modelReps
        }
        print(tableHistory.arrayModels.map{$0.workoutName})
        print(tableHistory.dateArray)
        print(tableHistory.arrayReps)

        
        // Третья сортировка - отделяем
    }
    
    deinit {
        print("statistics gone")
    }
}



extension StatisticViewController {
    private func setUpConstraints() {
        
        statisticLabel.setUpConstraints(atView: self.view)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 30),
            segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            excersiseLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 25),
            excersiseLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            tableHistory.topAnchor.constraint(equalTo: excersiseLabel.bottomAnchor),
            tableHistory.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableHistory.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableHistory.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
