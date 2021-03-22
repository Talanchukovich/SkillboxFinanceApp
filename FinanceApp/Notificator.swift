//
//  Notificator.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 16.03.2021.
//

import Foundation
import UIKit

protocol ObservableProtocol: class {
    var observers: [ObserverProtocol] {get set}
    func addObserver(_ observer: ObserverProtocol)
    func notify (incomes: [Income], expensCategories: [ExpensCategory], expenses: [Expens])
}

protocol ObserverProtocol: class {
    func loadNewData(incomes: [Income], expensCategories: [ExpensCategory], expenses: [Expens])
    func transferKeyboardHeight(keyboardHeight: CGFloat)
}
extension ObserverProtocol{
    func loadNewData(incomes: [Income], expensCategories: [ExpensCategory], expenses: [Expens]){}
    func transferKeyboardHeight(keyboardHeight: CGFloat){}
}


class Notificator:  ObservableProtocol {
    
    static let shared = Notificator()
   
    var observers: [ObserverProtocol] = []
    
    func addObserver(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: ObserverProtocol){
//        if let idx = observers.firstIndex(where: { $0 === observer }) {
//            observers.remove(at: idx)
//        }
        self.observers = observers.filter{$0 !== observer}
    }
    
    func notify(incomes: [Income], expensCategories: [ExpensCategory], expenses: [Expens]) {
        observers.forEach{$0.loadNewData(incomes: incomes, expensCategories: expensCategories, expenses: expenses)}
    }
    
    func notify(keyboardHeight: CGFloat){
        observers.forEach{$0.transferKeyboardHeight(keyboardHeight: keyboardHeight)}
    }
}
