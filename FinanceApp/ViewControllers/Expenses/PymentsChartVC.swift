//
//  PymentsChartVC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 08.04.2021.
//

import UIKit
import Charts
import SnapKit

class PymentsChartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        createChartView()
        setCharData()
    }
    
    lazy var lineChartView = LineChartView()
    
    func createChartView(){
        lineChartView.backgroundColor = .blue
        view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-80)
            make.top.equalToSuperview().offset(270)
        }
    }
    
    func setCharData(){
        lineChartView.data = FinanceViewModel.viewModel.lineChartData
    }
    
    

}
