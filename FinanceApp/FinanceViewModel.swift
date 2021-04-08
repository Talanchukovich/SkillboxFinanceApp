//
//  FinanceViewModel.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 07.04.2021.
//

import Foundation
import UIKit
import CoreData
import RxSwift
import RxCocoa
import Charts

class FinanceViewModel{
    
    static let viewModel = FinanceViewModel()
    
    lazy var incomes = PublishSubject<[Income]>()
    lazy var balance = PublishSubject<NSAttributedString>()
    lazy var expensCategories = PublishSubject<[ExpensCategory]>()
    lazy var expenses = PublishSubject<[Expens]>()
    lazy var keyboardHeight = PublishRelay<CGFloat>()
    var secondTxtFieldHeit: CGFloat = 0
    var lineChartData: LineChartData?
    
    // MARK: - Core Data
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var coreDataIncomes = [Income]()
    var coreDataExpensCategories = [ExpensCategory]()
    var coreDataExspenses = [Expens]()
    var category: ExpensCategory?
    
    // MARK: - getData
    
    func getData(menuType: MenuType) {
        do {
            switch menuType{
            case .income:
                coreDataIncomes = try context.fetch(Income.fetchRequest())
                let newBalance = String(coreDataIncomes
                    .map{Double($0.income?.filtred ?? "0")}
                    .compactMap{$0}
                    .reduce(0.0, +))
                    .stringWithSeparator
                    .attributed(attributes: TextAttributes.shared.balanceLabelAttributes)
                incomes.onNext(coreDataIncomes)
                balance.onNext(newBalance)
            
            case .expensCategory:
                coreDataExpensCategories = try context.fetch(ExpensCategory.fetchRequest())
                expensCategories.onNext(coreDataExpensCategories)
            
            case .expens:
                coreDataExspenses = try context.fetch(Expens.fetchRequest())
                let coreDataExspensesFiltred = coreDataExspenses.filter{$0.category == category}
                expenses.onNext(coreDataExspensesFiltred)
                
                let dataEntry = coreDataExspensesFiltred.map{ChartDataEntry(x: Double(coreDataExspensesFiltred.firstIndex(of: $0)!), y: Double($0.expens!.filtred)!, data: $0.expensDate?.dateFormated)}
                let lineChartDataSet = LineChartDataSet(entries: dataEntry)
                lineChartData = LineChartData(dataSet: lineChartDataSet)
              
                
            }
            
        } catch let error as NSError {
            print("Not get data == \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - adData
    
    func adData(menuType: MenuType, newName: String, newMoney: String){
        switch menuType{
        case .income:
            let newIncome = Income(context: context)
            newIncome.income = newName
            newIncome.incomeDate = Date()
        case .expensCategory:
            let newCategoryExpens = ExpensCategory(context: context)
            newCategoryExpens.categoryName = newName
        case .expens:
            let newExpens = Expens(context: context)
            newExpens.expensName = newName
            newExpens.expensDate = Date()
            newExpens.expens = newMoney
            newExpens.category = category
        }
        do {
            try context.save()
            getData(menuType: menuType)
        }catch let error as NSError {
            print("Not added \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - deletData
    
    func deletData(model: NSManagedObject, menuType: MenuType) {
        context.delete(model)
        
        do {
            try context.save()
            getData(menuType: menuType)
        }catch let error as NSError {
            print("Not deleted \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - editData
    
    func editData(model: NSManagedObject, newName: String, newMoney: String, menuType: MenuType){
        switch model{
        case model as? Income:
            guard let expensModel = model as? Income else {return}
            expensModel.income = newName
        case model as? ExpensCategory:
            guard let categoryModel = model as? ExpensCategory else {return}
            categoryModel.categoryName = newName
        case model as Expens:
            guard let expensModel = model as? Expens else {return}
            expensModel.expensName = newName
            expensModel.expens = newMoney
        default:
            break
        }
        do {
            try context.save()
            getData(menuType: menuType)
        } catch let error as NSError {
            print("Not edited == \(error), \(error.userInfo)")
        }
    }
}
