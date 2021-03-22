//
//  MenuVC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 18.03.2021.
//

import UIKit

enum MenuType {
    case income
    case expensCategory
    case expens
}

enum MenuMode {
    case adding
    case editing
}

class MenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

// MARK: Keyboard
        
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
                KeyboardProperties.shared.keyboardHeight = keyboardHeight
            Notificator.shared.notify(data: keyboardHeight)
            }
    }
    
//MARK: Properties
    
    let firstLabel = UILabel()
    let firstTextField = UITextField()
    let firstTextFieldLineView = UIView()
    
    let secondViewes = UIView()
    let secondLabel = UILabel()
    let secondTextField = UITextField()
    let secondTextFieldLineView = UIView()
    
    let button = UIButton()
    
    var index = 0
    var textFieldText = ""
    var menuTypeIsNow: MenuType?



    // MARK: Creating MenuViewes
    
    func createMenuViewes(menuType: MenuType, menuMode: MenuMode, editingText: String, index: Int){
        self.menuTypeIsNow = menuType
        self.index = index
        var textFieldText: String {
            switch menuMode{
            case .adding:
                return ""
            case .editing:
                return editingText
            
            }
        }
        self.textFieldText = textFieldText
        
        
        
        var labelText: String {
            switch menuType {
            case .income:
                return "Сумма"
            case .expensCategory:
                return "Наименование"
            case .expens:
                return "Наименование"
            }
        }
        
        var keyboardType: UIKeyboardType {
            switch menuType {
            case .income:
                return UIKeyboardType.decimalPad
            case .expensCategory:
                return UIKeyboardType.default
            case .expens:
                return UIKeyboardType.default
            }
        }
        
        var secondViewesIsHeaden: Bool {
            switch menuType{
            case .income:
                return true
            case .expensCategory:
                return true
            case .expens:
                return false
            }
        }
        
        var buttonConstraint: CGFloat {
            switch menuType{
            case .income:
                return 92
            case .expensCategory:
                return 92
            case .expens:
                return 167
            }
        }
        
        var buttonTitel: NSAttributedString {
            switch menuMode{
            case .adding:
                switch menuType {
                case .income:
                    return "Добавить доход".buttonTitelAttributed
                case .expensCategory:
                    return "Добавить категорию расходов".buttonTitelAttributed
                case .expens:
                    return "Добавить расход".buttonTitelAttributed
                }
            case .editing:
                switch menuType {
                case .income:
                    return "Редактировать доход".buttonTitelAttributed
                case .expensCategory:
                    return "Редактировать категорию расходов".buttonTitelAttributed
                case .expens:
                    return "Редактировать расход".buttonTitelAttributed
                }
            }
        }
        
        // MARK:  firstLabel
        
        firstLabel.isHidden = true
        firstLabel.attributedText = NSAttributedString(string: labelText, attributes: TextAttributes.shared.tfvLabelAttributes)
        view.addSubview(firstLabel)
        firstLabel.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
        }
        
        // MARK:  firstTxtField
        
        firstTextField.delegate = self
        firstTextField.becomeFirstResponder()
        firstTextField.returnKeyType = .next
        firstTextField.enablesReturnKeyAutomatically = true
        firstTextField.keyboardType = keyboardType
        firstTextField.clearButtonMode = .whileEditing
        firstTextField.attributedText = NSAttributedString(string: editingText, attributes: TextAttributes.shared.textFieldTextAttributes)
        firstTextField.attributedPlaceholder = NSAttributedString(string: labelText, attributes: TextAttributes.shared.textFieldPlaceHolderAttributes)
        firstTextField.addAction(.init(){[weak self]_ in
                                    guard let self = self else {return}
                                    self.textFieldAction()},
                                 for: .editingChanged)
        firstTextField.addAction(.init(){ [weak self]_ in
                                    guard let self = self else {return}
                                    self.secondTextField.becomeFirstResponder()},
                                 for: .primaryActionTriggered)
        view.addSubview(firstTextField)
        firstTextField.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(firstLabel.snp.bottom).offset(2)
        }
        
        // MARK:  firstTextFieldLineView
        
        firstTextFieldLineView.backgroundColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        view.addSubview(firstTextFieldLineView)
        firstTextFieldLineView.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(firstTextField.snp.bottom).offset(16)
            make.height.equalTo(0.5)
        }
        
        // MARK:  secondViewes
        
        secondViewes.isHidden = secondViewesIsHeaden
        view.addSubview(secondViewes)
        secondViewes.snp.makeConstraints{make in
            make.top.equalTo(firstTextFieldLineView.snp.bottom).offset(9.5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // MARK:  secondLabel
        
        secondLabel.isHidden = true
        secondLabel.attributedText = NSAttributedString(string: "Сумма", attributes: TextAttributes.shared.tfvLabelAttributes)
        secondViewes.addSubview(secondLabel)
        secondLabel.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        // MARK:  secondTextField
        
        secondTextField.delegate = self
        secondTextField.keyboardType = .decimalPad
        secondTextField.clearButtonMode = .whileEditing
        secondTextField.attributedText = NSAttributedString(string: editingText, attributes: TextAttributes.shared.textFieldTextAttributes)
        secondTextField.attributedPlaceholder = NSAttributedString(string: "Сумма", attributes: TextAttributes.shared.textFieldPlaceHolderAttributes)
        secondTextField.addAction(.init(){[weak self]_ in
                                    guard let self = self else {return}
                                    self.textFieldAction()},
                                  for: .editingChanged)
        secondViewes.addSubview(secondTextField)
        secondTextField.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(secondLabel.snp.bottom).offset(2)
        }
        
        // MARK:  secondTextFieldLineView
        
        secondTextFieldLineView.backgroundColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        secondViewes.addSubview(secondTextFieldLineView)
        secondTextFieldLineView.snp.makeConstraints {make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(secondTextField.snp.bottom).offset(16)
            make.height.equalTo(0.5)
        }
        
        // MARK:  button
        
        button.isEnabled = false
        button.setAttributedTitle(buttonTitel, for: .normal)
        button.addAction(.init(){[weak self]_ in
                            guard let self = self else {return}
                            self.dismissVC(menuType: menuType, menuMode: menuMode)},
                         for: .touchUpInside)
        button.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.5).cgColor
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        view.addSubview(button)
        button.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(buttonConstraint)
            make.centerX.equalToSuperview()
            make.width.equalTo(344)
            make.height.equalTo(48)
        }
    }
    
    // MARK: buttonAction
    
    func buttonAction(menuType: MenuType, menuMode: MenuMode){
        guard let firstText = firstTextField.text else {return}
        guard let secondText = secondTextField.text else {return}
        switch menuMode{
        case .adding:
            switch menuType{
            case .income:
                IncomeViewModel.incomeViewModel.adData(income: firstText)
            case .expensCategory:
                ExpencesViewModel.expencesViewModel.adData(category: firstText)
            case .expens:
                print("")
            }
        case .editing:
            switch menuType{
            case .income:
                IncomeViewModel.incomeViewModel.editData(index: index, income: firstText)
            case .expensCategory:
                ExpencesViewModel.expencesViewModel.editData(index: index, category: firstText)
            case .expens:
                print("")
            }
        }
    }
    
// MARK: Updating MenuView
    
    struct InputModelView {
        var menuType: MenuType
        var firstTextFieldIsEmpty: Bool
        var secondTextFieldIsEmpty: Bool
        
        var firstLabelIsHeaden: Bool{
            return firstTextFieldIsEmpty
        }
        var secondLabelIsHeaden: Bool{
            return secondTextFieldIsEmpty
        }
        var buttonIsEnabled: Bool {
            switch menuType{
            case .income:
                return !firstTextFieldIsEmpty
            case .expensCategory:
                return !firstTextFieldIsEmpty
            case .expens:
                return !firstTextFieldIsEmpty && !secondTextFieldIsEmpty
            }
        }
        var buttonColor: CGColor {
            switch buttonIsEnabled{
            case true:
                return UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
            case false:
                return UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.5).cgColor
            }
        }
    }
    
    struct OtputModelView {
        var firstLabelIsHeaden: Bool
        var secondLabelIsHeaden: Bool
        var buttonIsEnabled: Bool
        var buttonColor: CGColor
    }
    
    @discardableResult
    func updateView(inputModelView: InputModelView) -> OtputModelView{
        let outputModelView = OtputModelView(firstLabelIsHeaden: inputModelView.firstLabelIsHeaden,
                                             secondLabelIsHeaden: inputModelView.secondLabelIsHeaden,
                                             buttonIsEnabled: inputModelView.buttonIsEnabled,
                                             buttonColor: inputModelView.buttonColor)
        button.isEnabled = outputModelView.buttonIsEnabled
        button.layer.backgroundColor = outputModelView.buttonColor
        firstLabel.isHidden = outputModelView.firstLabelIsHeaden
        secondLabel.isHidden = outputModelView.secondLabelIsHeaden
        return outputModelView
    }
    
    func textFieldAction(){
        guard let firstText = firstTextField.text,
              let secondText = secondTextField.text,
              let menuTypeIsNow = menuTypeIsNow else {return}
        updateView(inputModelView: InputModelView(menuType: menuTypeIsNow, firstTextFieldIsEmpty: firstText.isEmpty, secondTextFieldIsEmpty: secondText.isEmpty))
    }
    
    func dismissVC(menuType: MenuType, menuMode: MenuMode){
        buttonAction(menuType: menuType, menuMode: menuMode)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: extension TextFieldDelegate

extension MenuVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.keyboardType == .decimalPad {
            firstTextField.selectedTextRange = firstTextField.textRange(from: firstTextField.position(from: firstTextField.endOfDocument, offset: -2) ?? firstTextField.endOfDocument, to: firstTextField.position(from: firstTextField.endOfDocument, offset: -2) ?? firstTextField.endOfDocument)
            secondTextField.selectedTextRange = secondTextField.textRange(from: secondTextField.position(from: secondTextField.endOfDocument, offset: -2) ?? secondTextField.endOfDocument, to: secondTextField.position(from: secondTextField.endOfDocument, offset: -2) ?? secondTextField.endOfDocument)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.keyboardType == .decimalPad {
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
            return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
        }
        return true
    }
}
