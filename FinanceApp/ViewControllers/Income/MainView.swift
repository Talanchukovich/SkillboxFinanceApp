////
////  MainView.swift
////  FinanceApp
////
////  Created by Андрей Таланчук on 04.03.2021.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class MainView {
//    
//    let mainView = UIView()
//    let currentBalanceView = UIView()
//    let desriptionLabel = UILabel()
//    let balanceLabel = UILabel()
//    let incomeView = UIView()
//    let buttonView = UIView()
//    let button = UIButton()
//    let incomeTabelView = UITableView()
//   
//    
//    func createMainView(){
//        
//       mainView.snp.makeConstraints{ make in
//            make.left.equalToSuperview()
//            make.top.equalToSuperview()
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
//        mainView.addSubview(currentBalanceView)
//        mainView.addSubview(incomeView)
//        mainView.addSubview(incomeTabelView)
//        mainView.addSubview(buttonView)
//        
//        desriptionLabel.attributedText = NSAttributedString(string: "Текущий баланс", attributes: TextAttributes.shared.currentBalanceAttributes)
//        currentBalanceView.addSubview(desriptionLabel)
//        
//            
//        // Set constraints
//        currentBalanceView.snp.makeConstraints{(make) in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalToSuperview()
//            make.height.equalTo(64)
//            
//        }
//        
//        desriptionLabel.snp.makeConstraints{ (make) in
//            make.left.equalToSuperview().offset(16)
//            make.centerY.equalToSuperview()
//        }
//
//
//        let incomeLabel = UILabel()
//        incomeLabel.attributedText = NSAttributedString(string: "Доходы", attributes: TextAttributes.shared.incomeLabelAttributes)
//        incomeLabel.lineBreakMode = .byWordWrapping
//        incomeView.addSubview(incomeLabel)
//        
//        incomeView.snp.makeConstraints{ make in
//            make.top.equalTo(currentBalanceView.snp.bottom)
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(64)
//        }
//        
//        incomeLabel.snp.makeConstraints{ make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
//    
//     
//      // MARK: - ButtonView
//        
//        
//        button.addTarget(self, action: #selector( IncomeViewController().openClosePopApView), for: .touchUpInside)
//        button.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
//        button.layer.cornerRadius = 24
//        button.clipsToBounds = true
//        buttonView.addSubview(button)
//        
//        let buttonLabel = UILabel()
//        buttonLabel.attributedText = NSAttributedString(string: "Добавить доход", attributes: TextAttributes.shared.buttonLabelAttributes)
//        button.addSubview(buttonLabel)
//
//        buttonView.snp.makeConstraints{ make in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(128)
//        }
//        
//        button.snp.makeConstraints{ make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.width.equalTo(344)
//            make.height.equalTo(48)
//        }
//        
//        buttonLabel.snp.makeConstraints{ make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
//    
//
//        incomeTabelView.register(IncomeCell.self, forCellReuseIdentifier: Keyes.shared.identifier_incomeCell)
//        incomeTabelView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        
//        incomeTabelView.snp.makeConstraints{ make in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalTo(incomeView.snp.bottom)
//            make.bottom.equalTo(buttonView.snp.top)
//        }
//    }
//    
//    func createBalanceLabel(){
//        
//        currentBalanceView.addSubview(balanceLabel)
//       
//        balanceLabel.snp.makeConstraints{ make in
//            make.right.equalToSuperview().offset(-20)
//            make.centerY.equalToSuperview()
//        }
//    }
//}
