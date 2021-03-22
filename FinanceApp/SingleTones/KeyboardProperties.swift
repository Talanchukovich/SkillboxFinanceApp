//
//  KeyboardProperties.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 13.03.2021.
//

import Foundation
import UIKit

class KeyboardProperties {
    
    static let shared = KeyboardProperties()
    private init() {}
    
    var keyboardHeight: CGFloat = 0
    var secondTxtFieldHeit: CGFloat = 0
}
