//
//  NavigationMenuController.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 19.02.2021.
//

import UIKit

class NavigationMenuController: UITabBarController {
    
    let textAttributes = TextAttributes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItemSettings()
        createTabBarItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setHeitTabBar()
    }
    
    
    
    // Set height of TabBar
    
    func setHeitTabBar(){
        let tabBarHeight: CGFloat = 52
        tabBar.frame.size.height = tabBarHeight + view.layoutMargins.bottom
        tabBar.frame.origin.y = view.frame.height - view.layoutMargins.bottom - tabBarHeight
    }
    
    // Set font and collor of TabBarItem
    
    func tabBarItemSettings () {
        tabBar.barTintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes(textAttributes.normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(textAttributes.selectedAttributes, for: .selected)
    }
    
    // Create tabBarItems for all ViewControllers
    
    func createTabBarItems(){
        let titels = ["Доходы", "График", "Расходы"]
        guard let items = tabBar.items else {return}
        for i in 0...(items.count - 1) {
            let customTabBarItem = items[i]
            customTabBarItem.title = titels[i]
            customTabBarItem.image = UIImage(systemName: "circle")
        
        }
    }
}
    
    


