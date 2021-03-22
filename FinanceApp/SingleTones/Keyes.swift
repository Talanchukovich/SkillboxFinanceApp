//
//  Keyes.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 22.02.2021.
//

import Foundation

class Keyes {
    
    static let shared = Keyes()
    private init() {}
    
    // MARK: Fonts
    
    let font_SFProDisplay_Medium = "SFProDisplay-Medium"
    let font_HelveticaNeueCyr_Black = "HelveticaNeueCyr-Black"
    
    // MARK: Celles
    
    let incomeCell = "incomeCell"
    let categoryCell = "categoryCell"
    let expensCell = "expensCell"
    
    // MARK: Formatter
    
    let locale = "RU_ru"
    let dateFormat = "E, d MMMM, yyyy"
    
    // MARK: SystemImages
    
    let chevron_right = "chevron.right"
    let chevron_forward = "chevron.forward"
    let delete_left = "delete.left"
    let text_redaction = "text.redaction"
    
    // MARK: StoryBoard and VC
    
    let storyBoardIdentifier = "Main"
    let menuVCIdentifier = "MenuVC"
    
}
