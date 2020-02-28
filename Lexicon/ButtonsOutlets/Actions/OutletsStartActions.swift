//
//  OutletsStartViewController.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Функционал доступных действий для кнопок в StartViewController.
// Функции вызываются из SetupStartButtons и вызывают функции в StartViewController.
// Синглтон объявляется в StartViewController

protocol ButtonDelegate {
     func routingToNextController(_ sender: String)
}

class OutletsStartActions {
   
    static let shared = OutletsStartActions()
    var delegate: ButtonDelegate?
    
    func startButtonAction(){
        delegate?.routingToNextController("start")
    }
    
    func lexiconButtonAction(){
        delegate?.routingToNextController("lexicon")
    }
    
    func badWordsButtonAction(){
        delegate?.routingToNextController("bad")
    }
    
    func textButtonAction(_ text: String){
        DataModel.shared.stringFromTextField = text
        delegate?.routingToNextController("swipe")
    }
    
}
