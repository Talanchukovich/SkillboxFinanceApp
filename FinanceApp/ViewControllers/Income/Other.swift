//
//  Other.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 02.03.2021.
//

import Foundation

//var text = tfvTextField.text
//let count = text?.count
//let index1 = text?.index(text!.startIndex, offsetBy: 1)
//
//if count! == 4 &&
//    text![index1!] != " "
//{
//    text?.insert(" ", at: index1!)
//    tfvTextField.text = text
//}
//if count! == 4 &&
//    text![index1!] == " "{
//    text?.remove(at: index1!)
//    tfvTextField.text = text
//}
//if count! == 4 &&
//    text![index1!] != " " &&
//    text![(text?.index(text!.startIndex, offsetBy: 3))!] != "."
//{
//    text?.insert(" ", at: index1!)
//    tfvTextField.text = text
//}
//
//if count! == 5 && text![(text?.index(text!.startIndex, offsetBy: 3))!] != "."{
//    text!.remove(at: (text?.index(text!.startIndex, offsetBy: 2))!)
//    text?.insert(" ", at: index1!)
//    tfvTextField.text = text
//}
//if count! == 6 && text![(text?.index(text!.startIndex, offsetBy: 2))!] != " " && text![(text?.index(text!.startIndex, offsetBy: 3))!] != "." && text![(text?.index(text!.startIndex, offsetBy: 3))!] != " "{
//    text?.remove(at: index1!)
//    text!.insert(" ", at: (text?.index(text!.startIndex, offsetBy: 2))!)
//    
//    tfvTextField.text = text
//}
//
//if count! == 6 && text![(text?.index(text!.startIndex, offsetBy: 3))!] == " " && text![(text?.index(text!.startIndex, offsetBy: 3))!] != "."{
//    text!.remove(at: (text?.index(text!.startIndex, offsetBy: 3))!)
//    text!.insert(" ", at: (text?.index(text!.startIndex, offsetBy: 2))!)
//    
//    tfvTextField.text = text
//}
//if count! == 7 && text![(text?.index(text!.startIndex, offsetBy: 3))!] != " " && text![(text?.index(text!.startIndex, offsetBy: 3))!] != "." {
//    text!.remove(at: (text?.index(text!.startIndex, offsetBy: 2))!)
//    text!.insert(" ", at: (text?.index(text!.startIndex, offsetBy: 3))!)
//    
//    tfvTextField.text = text
//}
//print(count)



//struct TextInputModel {
//    let text: String
//    var textFieldIsValid: Bool {
//        return text.count > 0
//    }
//}
//
//struct TextOutModel {
//    var labelIsHeaden: Bool
//    var buttonIsEnabled: Bool
//    var buttonLayerBgrColor: CGColor
//}
//
//enum Events {
//    case textFieldIsValid
//    case textFieldIsNotValid
//}
//
//func makeInputModel(events: Events, inputModel: TextInputModel, color: CGColor) ->TextOutModel {
//    switch events {
//    case .textFieldIsValid:
//        return TextOutModel(labelIsHeaden: inputModel.textFieldIsValid, buttonIsEnabled: inputModel.textFieldIsValid, buttonLayerBgrColor: color)
//    case .textFieldIsNotValid:
//        return TextOutModel(labelIsHeaden: inputModel.textFieldIsValid, buttonIsEnabled: inputModel.textFieldIsValid, buttonLayerBgrColor: color)
//    }
//}

//    func updateView(events: Events, color: CGColor){
//        let inputModel = makeInputModel(events: Events, inputModel: inputModel, color: color)
//        tfvLabel.isHidden = inputModel.
//    }

//var inputModel: TextInputModel? {
//    return TextInputModel.init(text: tfvTextField.text!)
//}





//        let text = tfvTextField.text?.filter({$0 != " "})
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.groupingSeparator = " "
//        let numberFromText = formatter.number(from: text!)
//        let formattedText = formatter.string(for: numberFromText)
//        newIncome = formattedText!
//        tfvTextField.text = formattedText
//        print(text)
//        print(numberFromText)
//        print(formattedText)
   
        

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = "Р"
//        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.beginningOfDocument)
//        guard let text = textField.text?.filter({$0 != " "}) else {return}
//                let formatter = NumberFormatter()
//                formatter.numberStyle = .decimal
//                formatter.groupingSeparator = " "
//        let numberFromText = formatter.number(from: text)
//                let formattedText = formatter.string(for: numberFromText)
//                newIncome = formattedText!
//        textField.text = formattedText ?? "" + "Р"
//
//    }
