////
////  TabItem.swift
////  FinanceApp
////
////  Created by Андрей Таланчук on 19.02.2021.
////
//
//import Foundation
//import UIKit
//
//enum TabItems: String, CaseIterable {
//    case income = "Доходы"
//    case charts = "График"
//    case expenses = "Расходы"
//    
//    var viewController: UIViewController {
//        switch self {
//        case .income:
//            return IncomesVC()
//        case .charts:
//            return ChartsViewController()
//        case .expenses:
//            return CategoriesVC()
//        }
//    }
//    
//    var icon: UIImage {
//        switch self{
//        case .charts, .expenses, .income:
//            return UIImage(systemName: "circle")!
//        }
//    }
//    
//    var displayTitel: String {
//        return self.rawValue.capitalized(with: nil)
//    }
//}
//
//class TabBarItems {
//    let titels = ["Доходы", "График", "Расходы"]
//}
