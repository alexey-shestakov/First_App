//
//  StatisticsTableView.swift
//  First_App
//
//  Created by Alexey Shestakov on 02.03.2023.
//

import UIKit

class StatisticsTabel: UITableView {
    
    //MARK: - Arrays with data
    public var arrayModels = [WorkoutModel]()   // Всем модели
    
    public var arrayReps = [[Int]]()
    public var dateArray = [[Date]]()
    
    public var countFromDate = Date()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
        seyUpDelegates()
        register(StatisticsTabelCell.self, forCellReuseIdentifier: StatisticsTabelCell.idCellTabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .none
        self.separatorStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func seyUpDelegates() {
        delegate = self
        dataSource = self
    }
    
    public func resetArrays() {
        arrayModels = []
        arrayReps = []
        dateArray = []
    }
}

extension StatisticsTabel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTabelCell.idCellTabel, for: indexPath) as? StatisticsTabelCell else {return UITableViewCell()}
        
        cell.configure(index: indexPath.row, delegate: self)
        
        return cell
    }
}

extension StatisticsTabel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
