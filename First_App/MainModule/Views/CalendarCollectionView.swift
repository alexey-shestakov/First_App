//
//  CalendarCollectionView.swift
//  First_App
//
//  Created by Alexey Shestakov on 24.02.2023.
//

import UIKit

protocol CalendarCollectionViewProtocol: AnyObject {    
    func selectItem(date: Date)
}

class CalendarCollectionView: UICollectionView {
    
    weak var mainVCdelegate: CalendarCollectionViewProtocol?
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    private let idCalendarCell = "idCalendarCell"
    
    private let weekArray = Date().getWeekArray()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        setUpLayout()
        register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell)
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        collectionLayout.minimumInteritemSpacing = 3
    }
    
    private func configure() {
        self.backgroundColor = .none  // Прозрачная
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}


// MARK: UICollectionViewDataSource

extension CalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath) as? CalendarCollectionViewCell else {return UICollectionViewCell() }
        
        cell.dateForCell(numberOfDay: weekArray[1][indexPath.item], dayOfWeek: weekArray[0][indexPath.item])
        if indexPath.item == 6 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
//            cell.isSelected = true // почему не работает?
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.specialDarkYellow.cgColor
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension CalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateTimeZone = Date()
        // сейчас ищем смещение, если допустим нажали на 3 по счету ячейку [] - куда нажали, ~~ - наш день
        // 0 1 [2] 3 4 5 ~6~
        let date = dateTimeZone.offsetDays(days: 6 - indexPath.item)
        mainVCdelegate?.selectItem(date: date)
    }
}



// MARK: UICollectionViewDelegateFlowLayout

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 8,
               height: collectionView.bounds.height)
    }
}
