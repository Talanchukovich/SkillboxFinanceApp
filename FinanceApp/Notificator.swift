//
//  Notificator.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 16.03.2021.
//

import Foundation

protocol ObservableProtocol: class {
    var observers: [ObserverProtocol] {get set}
    func addObserver(_ observer: ObserverProtocol)
    func notify (data: Any)
}

protocol ObserverProtocol: class {
    func loadNewData(data: Any)
}

class Notificator:  ObservableProtocol {
   
    var observers: [ObserverProtocol] = []
    
    func addObserver(_ observer: ObserverProtocol) {
        observers.append(observer)
    }
    
    func notify(data: Any) {
        observers.forEach{$0.loadNewData(data: data)}
    }
}
