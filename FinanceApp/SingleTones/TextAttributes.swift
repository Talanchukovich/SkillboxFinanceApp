//
//  TextAttributes.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 22.02.2021.
//

import Foundation
import UIKit


private func paragraphStyle(lineHeightMultiple: CGFloat) -> NSMutableParagraphStyle {
    let style = NSMutableParagraphStyle()
    style.lineHeightMultiple = lineHeightMultiple
    return style
}

class TextAttributes {
    
    
    static let shared = TextAttributes()
    private init() {}
    
    
   let normalAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 11) as Any,
                                .kern: 0.13,
                                .foregroundColor: UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)]
                            
    let selectedAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 11) as Any,
                                .kern: 0.13,
                                .foregroundColor: UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)]

    
    let currentLabelAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 16) as Any,
                                .kern: 0.15,
                                .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    let balanceLabelAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 24) as Any,
                                .kern: -0.41,
                                .paragraphStyle: paragraphStyle(lineHeightMultiple: 0.89),
                                .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
       
    let incomeLabelAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_HelveticaNeueCyr_Black, size: 28) as Any,
                                .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    
    
    let buttonTitleAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 15) as Any,
                                .kern: -0.22,
                                .paragraphStyle: paragraphStyle(lineHeightMultiple: 0.89),
                                .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    
    let cellLabelsAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 16) as Any,
                                .kern: 0.19,
                                .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    let labelAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 11) as Any,
                                .kern: -0.19,
                                .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.45),
                                .foregroundColor: UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)]
    
    let textFieldPlaceHolderAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 14) as Any,
                                .kern: -0.24,
                                .paragraphStyle: paragraphStyle(lineHeightMultiple: 1.14),
                                .foregroundColor: UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)]
    
    let textFieldTextAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 16) as Any,
                                .kern: -0.27,
                                .paragraphStyle: paragraphStyle(lineHeightMultiple: 1),
                                .foregroundColor: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)]
    
    let adExpensLabelAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_HelveticaNeueCyr_Black, size: 22) as Any,
                                .foregroundColor: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)]
    
    let exspensButtonTitleAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 22) as Any,
                                .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    
    let tabelHeaderLabelsAttributes = [NSAttributedString.Key
                                .font: UIFont(name: Keyes.shared.font_HelveticaNeueCyr_Black, size: 13) as Any,
                                .kern: 0.13,
                                .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)]
   
    let weakButtonTitleAttributes = [NSAttributedString.Key
                                        .font: UIFont(name: Keyes.shared.font_SFProDisplay_Medium, size: 22) as Any,
//                                .kern: -0.29,
//                                .paragraphStyle: paragraphStyle(lineHeightMultiple: 0.99),
                                .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
}

