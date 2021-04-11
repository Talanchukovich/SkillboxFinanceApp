//
//  ChartsViewModel.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 11.04.2021.
//

import Foundation
import Charts

enum NeededDayes: Int, CaseIterable{
    case weak = 7
    case month = 30
    case quater = 90
    case all = 0
}

class ChartsViewModel{
    
    static let chartsViewModel = ChartsViewModel()
    
    var filtredData: [(Double, Date)] = []
    var filtredDataNeededDayes: [(Double, Date)] = []
    var yValues: [Double] = []
    var chartData = LineChartData()
    var chartDataEntryes: [ChartDataEntry] = []
    
    
    // Filter reapiting date and sum expenses per day
    
    func filterData(){
        filtredData.removeAll()
        let coreDataExspenses = FinanceViewModel.viewModel.coreDataExspenses
        let array = coreDataExspenses.map{(Double($0.expens!.filtred), $0.expensDate?.chartDateFormated)}
        let array2 = coreDataExspenses.map{(Double($0.expens!.filtred), $0.expensDate!)}
        var firstElement = array[0].0!
        for i in 0...array.count - 2{
            if array[i].1 == array[i+1].1 {
                firstElement += array[i+1].0!
            } else {
                filtredData.append((firstElement, array2[i].1))
                firstElement = array[i+1].0!
            }
        }
        filtredData.append((firstElement, array2[array2.count - 1].1))
    }
    
    // Filter data per weak, month, quater
    
    func filterDataNededDayes(nededDayesAgo: NeededDayes){
        clearAllData()
        switch nededDayesAgo {
        case .weak, .month, .quater:
            let nowDate = Date()
            var nededDayesAgoComponent = DateComponents()
            nededDayesAgoComponent.day =  -nededDayesAgo.rawValue
            let dayesAgo = Calendar.current.date(byAdding: nededDayesAgoComponent, to: nowDate)!
            for i in 0...filtredData.count - 1{
                if filtredData[i].1 > dayesAgo {
                    filtredDataNeededDayes.append(filtredData[i])
                }
            }
           createYValues(data: filtredDataNeededDayes)
        case .all:
           createYValues(data: filtredData)
        }
    }
    
    func createYValues(data: [(Double, Date)]){
        var firstElement = data[0].0
        for i in 0...data.count - 2{
            if data[i].1 == data[i+1].1 {
                firstElement += data[i+1].0
            } else {
                yValues.append(firstElement)
                firstElement = data[i+1].0
            }
        }
        yValues.append(firstElement)
        createChartDataEntryes(yValues: yValues)
    }
    
    func createChartDataEntryes(yValues: [Double]){
        for i in 0...yValues.count - 1{
            chartDataEntryes.append(ChartDataEntry(x: Double(i), y: yValues[i]))
        }
    }
    
    func clearAllData(){
        filtredDataNeededDayes.removeAll()
        yValues.removeAll()
        chartDataEntryes.removeAll()
    }
}
    
   
    
    
    
    
