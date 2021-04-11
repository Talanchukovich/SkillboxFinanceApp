//
//  PymentsChartVC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 08.04.2021.
//

import UIKit
import Charts
import SnapKit
import RxCocoa
import RxSwift

class PymentsChartVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChartsViewModel.chartsViewModel.filterData()
        ChartsViewModel.chartsViewModel.filterDataNededDayes(nededDayesAgo: .weak)
        createChartView(nededDayesAgo: .weak)
        createButtonsStuck()
        bindButtons()
    }
    
    let lineChartView = LineChartView()
    let weakButton = UIButton()
    let monthButton = UIButton()
    let quaterButton = UIButton()
    let allButton = UIButton()
    let bag = DisposeBag()
    
   
    func createChartView(nededDayesAgo: NeededDayes){
        
        let set = LineChartDataSet(entries: ChartsViewModel.chartsViewModel.chartDataEntryes)
        set.circleHoleRadius = 3
        set.circleHoleColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
        set.circleColors = [UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)]
        set.circleRadius = 4
        set.lineWidth = 1
        set.setColor(UIColor(red: 0.915, green: 0.073, blue: 0.073, alpha: 1))
        set.label = "График"
        
        let chartData = LineChartData(dataSet: set)
        chartData.setDrawValues(false)
        
        lineChartView.data = chartData
        lineChartView.rightAxis.enabled = false
        view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-130)
            make.top.equalToSuperview().offset(270)
        }
        
        formatLegend(legend: lineChartView.legend)
        formatXAxes(xAxis: lineChartView.xAxis, nededDayesAgo: nededDayesAgo)
        formatLeftAxxes(leftAxes: lineChartView.leftAxis)
    }
    
    func formatLegend(legend: Legend){
        legend.horizontalAlignment = .center
    }
    
    func formatXAxes(xAxis: XAxis, nededDayesAgo: NeededDayes){
        var xAxisValue: [String] = []
        switch nededDayesAgo {
        case .weak, .month, .quater:
            xAxisValue = ChartsViewModel.chartsViewModel.filtredDataNeededDayes
                .map{($0.1.chartDateFormated)}
                .reduce(into: []) {!$0.contains($1) ? $0.append($1) : ()}
        case .all:
            xAxisValue = ChartsViewModel.chartsViewModel.filtredData
                .map{($0.1.chartDateFormated)}
                .reduce(into: []) {!$0.contains($1) ? $0.append($1) : ()}
        }
        xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValue)
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont(name: Keyes.shared.font_HelveticaNeueCyr_Black, size: 12) ?? .systemFont(ofSize: 12)
        xAxis.axisMinimum = 0
        if xAxisValue.count > 2{
            xAxis.setLabelCount(xAxisValue.count - 1, force: false)
        } else {
            xAxis.setLabelCount(3, force: false)
            }
        xAxis.spaceMax = 0.5
    }
    
    func formatLeftAxxes(leftAxes: YAxis){
        leftAxes.labelFont = UIFont(name: Keyes.shared.font_HelveticaNeueCyr_Black, size: 12) ?? .systemFont(ofSize: 12)
        leftAxes.axisMinimum = 0
        leftAxes.drawBottomYLabelEntryEnabled = false
    }
    
    func createButtonsStuck(){
        
        let buttonsArray = [weakButton, monthButton, quaterButton, allButton]
        
        for i in 0...buttonsArray.count - 1 {
            let buttomFrame = UIView()
            buttomFrame.layer.borderWidth = 1
            buttomFrame.layer.borderColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1).cgColor
            buttomFrame.layer.cornerRadius = 2
            buttomFrame.clipsToBounds = true
            buttonsArray[i].insertSubview(buttomFrame, at: 0)
            buttomFrame.snp.makeConstraints{make in
                make.left.equalToSuperview().offset(-5)
                make.top.equalToSuperview()
                make.width.equalToSuperview().offset(10)
                make.height.equalToSuperview()
            }
            
            let buttomLine = UIView()
            buttomLine.backgroundColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
            buttonsArray[i].addSubview(buttomLine)
            buttomLine.snp.makeConstraints{make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(1)
                make.top.equalTo(buttonsArray[i].snp.bottom).offset(-1)
            }
        }
        
        weakButton.setAttributedTitle(NSAttributedString(string: "Неделя", attributes: TextAttributes.shared.weakButtonTitleAttributes), for: .normal)
       
        monthButton.setAttributedTitle(NSAttributedString(string: "Месяц", attributes: TextAttributes.shared.weakButtonTitleAttributes), for: .normal)
        monthButton.subviews.first?.isHidden = true
        
        quaterButton.setAttributedTitle(NSAttributedString(string: "Квартал", attributes: TextAttributes.shared.weakButtonTitleAttributes), for: .normal)
        quaterButton.subviews.first?.isHidden = true
        
        allButton.setAttributedTitle(NSAttributedString(string: " Все ", attributes: TextAttributes.shared.weakButtonTitleAttributes), for: .normal)
        allButton.subviews.first?.isHidden = true
       
        
        let buttonStack = UIStackView(arrangedSubviews: buttonsArray)
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalCentering
        buttonStack.spacing = 5
        view.addSubview(buttonStack)
        buttonStack.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(-26)
            make.height.equalTo(25)
            make.top.equalToSuperview().offset(158)
        }
    }
        
    func animateButtons(activButton: UIButton, inactivButon: [UIButton]){
        UIView.animate(withDuration: 0.3){
            activButton.subviews.first?.isHidden = false
            for button in inactivButon {
                button.subviews.first?.isHidden = true
            }
        }
    }
    func bindButtons(){
        weakButton.rx.tap
            .subscribe(onNext: { [self] in
                ChartsViewModel.chartsViewModel.filterDataNededDayes(nededDayesAgo: .weak)
                createChartView(nededDayesAgo: .weak)
                animateButtons(activButton: weakButton, inactivButon: [monthButton, quaterButton, allButton])
            }).disposed(by: bag)
        
        monthButton.rx.tap
            .subscribe(onNext: { [self] in
                ChartsViewModel.chartsViewModel.filterDataNededDayes(nededDayesAgo: .month)
                createChartView(nededDayesAgo: .month)
                animateButtons(activButton: monthButton, inactivButon: [weakButton, quaterButton, allButton])
            }).disposed(by: bag)
        
        quaterButton.rx.tap
            .subscribe(onNext: { [self] in
                ChartsViewModel.chartsViewModel.filterDataNededDayes(nededDayesAgo: .quater)
                createChartView(nededDayesAgo: .quater)
                animateButtons(activButton: quaterButton, inactivButon: [weakButton, monthButton, allButton])
            }).disposed(by: bag)
        
        allButton.rx.tap
            .subscribe(onNext: { [self] in
                ChartsViewModel.chartsViewModel.filterDataNededDayes(nededDayesAgo: .all)
                createChartView(nededDayesAgo: .all)
                animateButtons(activButton: allButton, inactivButon: [weakButton, monthButton, quaterButton])
            }).disposed(by: bag)
    }
}
