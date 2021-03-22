//
//  IncomesVC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 20.03.2021.
//

import UIKit
import CoreData
import SnapKit
import CoreImage

extension IncomesVC: ObserverProtocol {
    func loadNewData(incomes: [Income], expensCategories: [ExpensCategory], expenses: [Expens]) {
        self.incomes = incomes
    }
}

class IncomesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CoreDataManager.coreDataManager.addObserver(self)
        CoreDataManager.coreDataManager.getData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
       // IncomeViewModel.incomeViewModel.removeObserver(self)
        CoreDataManager.coreDataManager.removeObserver(self)
    }
    
// MARK: IncomesData
    
   
    var incomes: [Income] = []{
        didSet {
            let balances = incomes.map{Double($0.income?.filtred ?? "")}
            let sumOfBalances = balances.reduce(0.0) {(tottal, next) in
                guard let next = next else {return 0}
                return tottal + next}
            let screenBalance = String(sumOfBalances).stringWithSeparator
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.incomesTabelView.reloadData()
                self.balanceLabel.attributedText = NSAttributedString(string: screenBalance, attributes: TextAttributes.shared.balanceLabelAttributes)
            }
        }
    }
    
    
// MARK: Createeng MainView

    let currentLabel = UILabel()
    let balanceLabel = UILabel()
    let incomeLabel = UILabel()
    let incomesTabelView = UITableView()
    let button = UIButton()
    var alertTextfield = UITextField()
    var income: Income?
    
   
    func createMainView(){
       
        // MARK: currentLabel
        
        currentLabel.attributedText = NSAttributedString(string: "Текущий баланс", attributes: TextAttributes.shared.currentLabelAttributes)
        view.addSubview(currentLabel)
        currentLabel.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        // MARK: balanceLabel
    
        view.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints {make in
            make.right.equalToSuperview().offset(-20)
            make.firstBaseline.equalTo(currentLabel)
        }
        
        // MARK: incomeLabel

        incomeLabel.attributedText = NSAttributedString(string: "Доходы", attributes: TextAttributes.shared.incomeLabelAttributes)
        view.addSubview(incomeLabel)
        incomeLabel.snp.makeConstraints {make in
            make.top.equalTo(currentLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        // MARK: button
        
        button.setAttributedTitle("Добавить доход".buttonTitelAttributed, for: .normal)
        button.addAction(.init(){[weak self]_ in
                            guard let self = self else {return}
                            self.openMenuVC(menuMode: .adding)},
                         for: .touchUpInside)
        button.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        view.addSubview(button)
        button.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-56)
            make.width.equalTo(344)
            make.height.equalTo(48)
        }
        
        // MARK: incomesTabelView
        
        incomesTabelView.dataSource = self
        incomesTabelView.delegate = self
        incomesTabelView.register(IncomeCell.self, forCellReuseIdentifier: Keyes.shared.incomeCell)
        incomesTabelView.rowHeight = 64
        incomesTabelView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(incomesTabelView)
        incomesTabelView.snp.makeConstraints{make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(incomeLabel.snp.bottom).offset(9)
            make.bottom.equalTo(button.snp.top).offset(-43)
        }
    }
    
    // MARK: openMenuVC
    
    func openMenuVC(menuMode: MenuMode) {
        let menuVC = UIStoryboard(name: Keyes.shared.storyBoardIdentifier, bundle: nil).instantiateViewController(withIdentifier: Keyes.shared.menuVCIdentifier) as! MenuVC
        menuVC.modalPresentationStyle = .custom
        menuVC.transitioningDelegate = self
        switch menuMode {
        case.adding:
            menuVC.createMenuViewes(menuType: .income, menuMode: menuMode, model: income as Any)
        case.editing:
            menuVC.createMenuViewes(menuType: .income, menuMode: menuMode, model: income as Any)
        }
        present(menuVC, animated: true, completion: nil)
    }
    
    
// MARK: Dismiss Alert
    
    @objc func tap (){
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: TransitioningDelegate

extension IncomesVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MenuPC(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: TabelView

extension IncomesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = incomesTabelView.dequeueReusableCell(withIdentifier: Keyes.shared.incomeCell) as! IncomeCell
        let cellIncome = incomes[indexPath.row]
        cell.moneyLabel.text = cellIncome.income?.stringWithSeparator
        cell.dateLabel.text = cellIncome.incomeDate?.dateFormated
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let identifier = "\(index)" as NSString
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { _ in
            let deletAction = UIAction(title: "Удалить",
                                       image: UIImage(systemName: Keyes.shared.delete_left),
                                       identifier: nil,
                                       attributes: .destructive) {[weak self]_ in
                guard let self = self else {return}
                CoreDataManager.coreDataManager.deletData(model: self.incomes[indexPath.row])
            }
            let editAction = UIAction(title: "Редактировать",
                                      image: UIImage(systemName: Keyes.shared.text_redaction),
                                      identifier: nil) {[weak self] _ in
                guard let self = self else {return}
                self.income = self.incomes[indexPath.row]
                self.openMenuVC(menuMode: .editing)
            }
            return UIMenu(children: [deletAction, editAction])
        }
    }
    
 // MARK: UIAlertController
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        incomesTabelView.deselectRow(at: indexPath, animated: true)
        income = incomes[indexPath.row]
        let sheet = UIAlertController(title: nil, message: "Отредактируйте или удалите запись", preferredStyle: .actionSheet)
        let alert = UIAlertController(title: "Редактировать", message:  "Введите новую сумму", preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            guard let self = self else {return}
            self.alertTextfield = textField
            textField.delegate = self
            textField.keyboardType = .decimalPad
            textField.clearButtonMode = .always
        }
        alert.view.snp.makeConstraints{make in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(view.bounds.size.height / 4)
        }
        
        let editAction = UIAlertAction(title: "Редактировать", style: .default){[weak self] _ in
                        guard let self = self else {return}
                        self.present(alert, animated: true, completion:{
                        alert.view.superview?.isUserInteractionEnabled = true
                        alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap)))})}
     
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: {[weak self]_ in
            guard let self = self else {return}
            CoreDataManager.coreDataManager.deletData(model: self.incomes[indexPath.row])
        })
        
        let doneAction = UIAlertAction(title: "Готово", style: .default, handler: {[weak self] _ in
            guard let self = self else {return}
            guard let text = self.alertTextfield.text else {return}
            guard let income = self.income else {return}
            CoreDataManager.coreDataManager.editData(model: income, newName: text, newMoney: "")
        })
        sheet.addAction(editAction)
        sheet.addAction(cancelAction)
        sheet.addAction(deleteAction)
        alert.addAction(doneAction)
        
        present(sheet, animated: true, completion: nil)
    }
}

// MARK: Textfield delegate

extension IncomesVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text,
              let r = Range(range, in: oldText),
              let decimal = NSLocale.current.decimalSeparator
               else {return true}
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || CharacterSet(charactersIn: "0123456789" + decimal).isSuperset(of: CharacterSet(charactersIn: string))
        let numberOfDots = newText.components(separatedBy: decimal).count - 1
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: decimal.first!) {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }

            return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 4
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.text = " Р"
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.beginningOfDocument)
        let text = income?.income
        alertTextfield.text = text?.stringWithSeparator
        alertTextfield.selectedTextRange = alertTextfield.textRange(from: alertTextfield.position(from: alertTextfield.endOfDocument, offset: -2)!, to: alertTextfield.position(from: alertTextfield.endOfDocument, offset: -2)!)
    }

}

