//
//  ExpensesVC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 17.03.2021.
//

import UIKit
import RxSwift

class ExpensesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createMainView()
        FinanceViewModel.viewModel.getData(menuType: .expens)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FinanceViewModel.viewModel.secondTxtFieldHeit = 80
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        FinanceViewModel.viewModel.secondTxtFieldHeit = 0
    }
    
    
// MARK:- Properties MainView
    
    let chartButton = UIButton()
    let expensesTabelView = UITableView()
    let openButton = UIButton()
    let adExpensLabel = UILabel()
    var category: ExpensCategory?
    var expens: Expens?
    let bag = DisposeBag()
    
    
// MARK:- Creating MainView
    
    func createMainView(){
        
        // MARK:- chartButton
        
        chartButton.setAttributedTitle(NSAttributedString(string: "График платежей", attributes: TextAttributes.shared.buttonTitleAttributes), for: .normal)
        chartButton.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        chartButton.layer.cornerRadius = 24
        view.addSubview(chartButton)
        chartButton.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.width.equalTo(344)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
        // MARK:- adExpensLabel
        
        adExpensLabel.attributedText = NSAttributedString(string: "Добавить расход", attributes: TextAttributes.shared.adExpensLabelAttributes)
        view.addSubview(adExpensLabel)
        adExpensLabel.snp.makeConstraints{make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.centerX.equalToSuperview()
        }
        
        // MARK:- openButton
        
        openButton.addAction(.init(){[weak self]_ in
                                guard let self = self else {return}
                                self.openMenuVC(menuMode: .adding)},for: .touchUpInside)
        openButton.setAttributedTitle(NSAttributedString(string: "+", attributes: TextAttributes.shared.exspensButtonTitleAttributes), for: .normal)
        openButton.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        openButton.layer.cornerRadius = 28
        view.addSubview(openButton)
        openButton.snp.makeConstraints{make in
            make.bottom.equalTo(adExpensLabel.snp.top).offset(-8)
            make.width.equalTo(56)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }
        
        // MARK:- expensesTabelView
        FinanceViewModel.viewModel.category = category
        FinanceViewModel.viewModel.expenses
            .asObservable()
            .bind(to: expensesTabelView.rx.items(cellIdentifier: Keyes.shared.expensCell, cellType: ExpensCell.self))
            {row, model, cell in
                    cell.expNameLabel.text = model.expensName
                    cell.dateLabel.text = model.expensDate?.expensDateFormated
                    cell.expLabel.text = model.expens?.stringWithSeparator
            }.disposed(by: bag)
        
        expensesTabelView.delegate = self
        expensesTabelView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        expensesTabelView.register(ExpensCell.self, forCellReuseIdentifier: Keyes.shared.expensCell)
        expensesTabelView.rowHeight = 39
        view.addSubview(expensesTabelView)
        expensesTabelView.snp.makeConstraints{make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(chartButton.snp.bottom).offset(33)
            make.bottom.equalTo(openButton.snp.top).offset(-12)
        }
    }
    
    // MARK: openMenuVC
    
    func openMenuVC(menuMode: MenuMode){
        let menuVC = UIStoryboard(name: Keyes.shared.storyBoardIdentifier, bundle: nil).instantiateViewController(withIdentifier: Keyes.shared.menuVCIdentifier) as! MenuVC
        menuVC.modalPresentationStyle = .custom
        menuVC.transitioningDelegate = self
        switch menuMode{
        case .adding:
            menuVC.createMenuViewes(menuType: .expens, menuMode: menuMode)
        case .editing:
            menuVC.model = expens
            menuVC.createMenuViewes(menuType: .expens, menuMode: menuMode)
        }
        present(menuVC, animated: true, completion: nil)
    }
    
}

extension ExpensesVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let expensesPC = MenuPC(presentedViewController: presented, presenting: presenting)
        return expensesPC
    }
}

extension ExpensesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 22))
        headerView.backgroundColor = .white
        let label1 = UILabel()
        label1.attributedText = NSAttributedString(string: "На что", attributes: TextAttributes.shared.tabelHeaderLabelsAttributes)
        let label2 = UILabel()
        label2.attributedText = NSAttributedString(string: "Когда", attributes: TextAttributes.shared.tabelHeaderLabelsAttributes)
        let label3 = UILabel()
        label3.attributedText = NSAttributedString(string: "Сколько", attributes: TextAttributes.shared.tabelHeaderLabelsAttributes)
        headerView.addSubview(label1)
        headerView.addSubview(label2)
        headerView.addSubview(label3)
        label1.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        label2.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        label3.snp.makeConstraints{make in
            make.right.equalToSuperview().offset(-37)
            make.centerY.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let identifier = "\(index)" as NSString
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _ in
            let deletAction = UIAction(title: "Удалить",
                                       image: UIImage(systemName: Keyes.shared.delete_left),
                                       identifier: nil,
                                       attributes: .destructive) {_ in
                FinanceViewModel.viewModel.deletData(model: FinanceViewModel.viewModel.coreDataExspenses[indexPath.row], menuType: .expens)
               
            }
            let editAction = UIAction(title: "Редактировать",
                                      image: UIImage(systemName: Keyes.shared.text_redaction),
                                      identifier: nil) {[weak self] _ in
                guard let self = self else {return}
                self.expens = FinanceViewModel.viewModel.coreDataExspenses[indexPath.row]
                self.openMenuVC(menuMode: .editing)
            }
            return UIMenu(children: [deletAction, editAction])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
