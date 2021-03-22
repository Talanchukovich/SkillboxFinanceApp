//
//  CoreDataManager.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 22.03.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: Notificator {
    
    static let coreDataManager = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var coreDataIncomes = [Income]()
    var coreDataExpensCategories = [ExpensCategory]()
    var coreDataExspenses = [Expens]()
    
    func getData() {
        do {
            coreDataIncomes = try context.fetch(Income.fetchRequest())
            coreDataExpensCategories = try context.fetch(ExpensCategory.fetchRequest())
            coreDataExspenses = try context.fetch(Expens.fetchRequest())
            notify(incomes: coreDataIncomes, expensCategories: coreDataExpensCategories, expenses: coreDataExspenses)
            
        } catch let error as NSError {
            print("Not get data == \(error), \(error.userInfo)")
        }
    }
    
    func adData(menuType: MenuType, newName: String, newMoney: String, model: Any){
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
            newExpens.category = model as? ExpensCategory
        }
        do {
            try context.save()
            getData()
        }catch let error as NSError {
            print("Not added \(error), \(error.userInfo)")
        }
    }
    
    func deletData(model: NSManagedObject) {
        context.delete(model)
        
        do {
            try context.save()
            getData()
        }catch let error as NSError {
            print("Not deleted \(error), \(error.userInfo)")
        }
    }
    
    func editData(model: NSManagedObject, newName: String, newMoney: String){
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
            getData()
        } catch let error as NSError {
            print("Not edited == \(error), \(error.userInfo)")
        }
    }
}
