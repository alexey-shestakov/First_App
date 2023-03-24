//
//  MainTabBarController.swift
//  First_App
//
//  Created by Alexey Shestakov on 05.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        setUpItems()
    }
    
    private func setUpTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
//        print(tabBar.frame.height) - // есть фрейм
        tabBar.bounds = tabBar.bounds.insetBy(dx: 0, dy: -10)
    }
    
    private func setUpItems() {
        let mainVC = MainViewController()
        let statisticdVS = StatisticViewController()
        
        self.setViewControllers([mainVC, statisticdVS], animated: true)
        guard let items = tabBar.items else {return}
//        items[0].title = "Main"
//        items[1].title = "Statistics"
        
        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "statisticTabBar")
        
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    }
}
