//
//  UIColors.swift
//  Lexicon
//
//  Created by admin on 28.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit


class UIColors {
    static let shared = UIColors()
    
    func getBackgroundColour()-> UIColor {
        return (UIColor(red:0.97, green:0.84, blue:0.58, alpha:1.0))
    }
    
    func getTextColour() -> UIColor {
        return (UIColor(red:0.34, green:0.29, blue:0.56, alpha:1.0))
    }
    
    func getCellColour() -> UIColor {
        return (UIColor(red:0.99, green:0.94, blue:0.80, alpha:1.0))
    }
    
    func getCellTextFieldColour() -> UIColor {
        return (UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.0))
    }
}
