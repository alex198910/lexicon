//
//  ViewController.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Стартовый  ViewController. Первый экран.

class StartViewController: UIViewController, ButtonDelegate {
    
    var ButtonsView = SetupStartButtons.shared
    var ActionsOfOutlets = OutletsStartActions.shared
    var Rout = RoutStartViewController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        delgateSelf()
        setupView()
        DataModel.shared.deleteDoublersInCoreData()
    }
    
    func delgateSelf(){
        ActionsOfOutlets.delegate = self
        Rout.navigationController = self.navigationController
        ButtonsView.selfView = self.view
    }

    func setupView(){
        view.backgroundColor = UIColor(red:0.97, green:0.84, blue:0.58, alpha:1.0)
        ButtonsView.setup()
    }
    
    //ButtonDelegate
    func routingToNextController(_ sender: String){
        switch sender {
        case "start":
            Rout.goToTextFieldController()
        case "lexicon":
            Rout.goToTableViewWithLexicon()
        case "bad":
            Rout.goToTableViewWithBadWords()
        case "swipe":
            Rout.goToMain()
            Rout.goToSwipeController()
        default: return
        }
    }


}

