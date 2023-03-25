//
//  ViewController.swift
//  First_App
//
//  Created by Alexey Shestakov on 21.02.2023.
//
import UIKit

class MainViewController: UIViewController {
    
    var newWorkoutClosure = {
        let vc = NewWorkoutViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    var workoutViewController: NewWorkoutViewController?
    
    private var tableView = MainTableView()
    
    var selectedDate = Date().localDate()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "me")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your name"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5                              // от изначального, если меньше то нет
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.8392156863, blue: 0.3568627451, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal)
        button.tintColor = .specialDarkGreen
        button.titleLabel?.font = .robotoMedium12()
        button.imageEdgeInsets = .init(top: 0,
                                       left: 20,
                                       bottom: 15,
                                       right: 0)
        button.titleEdgeInsets = .init(top: 50,
                                       left: -40,
                                       bottom: 0,
                                       right: 0)
        button.addTarget(self, action: #selector(addWorkoutButonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let calendarView = CalendarView()
    let weatherView = WeatherView()
    private let workoutTodayLabel = UILabel(textLightBrown: "Workout today")
    
    public var workoutArray = [WorkoutModel]() {
        didSet {
            allTrainingsButton.setTitle(" \(RealmManager.shared.getResultWorkoutModel().count)", for: .normal)

        }
    }
    private lazy var allTrainingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .specialDarkGreen
        button.titleLabel?.font = .robotoMedium12()
        button.setTitle("All", for: .normal)
        button.setImage(UIImage(systemName: "square.stack.3d.up"), for: .normal)
        button.addTarget(self, action: #selector(allWorkouts), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLayoutSubviews() { // перерисовка объектов и определения границ
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setConstaints()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectItem(date: selectedDate)
    }
    
    
    //MARK: - Set Delegates
    private func setDelegates() {
        calendarView.setDelegate(delegate: self)
        tableView.mainVC = self
        tableView.mainDelegate = self
    }

    private func setUpViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        
        
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
        view.addSubview(noWorkoutImageView)
        view.addSubview(allTrainingsButton)
    }
    
    @objc
    private func addWorkoutButonTapped() {
        guard let workoutViewController = workoutViewController else {
            self.workoutViewController = newWorkoutClosure()
            self.workoutViewController?.delegate = self
            guard let newWorkoutViewController = self.workoutViewController else {return }
            present(newWorkoutViewController, animated: true)
            return
        }
        present(workoutViewController, animated: true)
    }
    
    @objc
    private func allWorkouts() {
        let allworkoutsVC = AllTrainingsViewController()
        allworkoutsVC.modalPresentationStyle = .fullScreen
        present(allworkoutsVC, animated: true)
    }
//    private func getWorkouts(date: Date) {
//        let resultArray = RealmManager.shared.getResultWorkoutModel()
//
//        let weekDay = date.getNumberOfDay() //для первого условия (что повторяется каждые 7 дней)
//        let dateStart = date.startEndDate().start
//        let dateEnd = date.startEndDate().end
//
//        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekDay) AND workoutRepeat = true")
//        let predicateForDate = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
//
//        // объединяем 2 условия (1 условие ИЛИ 2 условие)
//        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateForDate])
//
//        let filteredArray = resultArray.filter(compound).sorted(byKeyPath: "workoutName")
//        workoutArray = filteredArray.map{ $0 }  // Записывет каждое значение в пустой масиив из filteredArray
//    }
    
    private func getWorkouts(date: Date) {      // Сортировка по дате без 
        let resultArray = RealmManager.shared.getResultWorkoutModel()
        
        let weekDay = date.getNumberOfDay()
        let dateNeeded = date.onlyDate()
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekDay) AND workoutRepeat = true")
        let predicateForDate = NSPredicate(format: "workoutRepeat = false AND workoutDate = %@", dateNeeded as NSDate)

        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateForDate])

        let filteredArray = resultArray.filter(compound).sorted(byKeyPath: "workoutName")       // В filteredArray запишет все отфильтрованные модели
        workoutArray = filteredArray.map{ $0 }                                     // Записать все напрямую в workoutArray нельзя (разные типы масиивов)
    }
    
    
    private func checkWorkoutToday() {
        noWorkoutImageView.isHidden = !workoutArray.isEmpty
        tableView.isHidden = workoutArray.isEmpty
    }
    
    deinit {
        print("app gone")
    }
}

extension MainViewController: CalendarCollectionViewProtocol {
    func selectItem(date: Date) {
        selectedDate = date
        getWorkouts(date: date)                                 // Нажимая на даты, workoutArray обновляется
        tableView.reloadData()
        checkWorkoutToday()                                             // Проверяем есть ли в workoutArray данные
    }
}


//MARK: - MainTableViewProtocol
extension MainViewController: MainTableViewProtocol {
    func deleteWorkout(model: WorkoutModel, index: Int) {
        RealmManager.shared.deleteTraining(model: model)
        workoutArray.remove(at: index)
        tableView.reloadData()
    }
}

//MARK: - WorkoutCellProtocol
extension MainViewController: WorkoutCellProtocol {
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
            let repsWorkoutVC = RepsWorkoutViewController()
            repsWorkoutVC.modalPresentationStyle = .fullScreen
            present(repsWorkoutVC, animated: true)
        } else {
            print("timer")
        }
    }
}


extension MainViewController {
    private func setConstaints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 6),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 6),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80),
            
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noWorkoutImageView.heightAnchor.constraint(equalTo: noWorkoutImageView.widthAnchor, multiplier: 0.9),
            
            allTrainingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            allTrainingsButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            allTrainingsButton.heightAnchor.constraint(equalToConstant: 30),
            allTrainingsButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}

