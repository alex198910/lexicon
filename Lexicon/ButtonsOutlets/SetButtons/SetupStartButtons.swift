//
//  Represent.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Установка кнопок, положения и их параметров в StartViewController
//  Установка значений при срабатывании и вызов функции в OutletStartActions.

class SetupStartButtons {
    static let shared = SetupStartButtons()
    
    weak var SelfView: UIView?
    let Lexicon: UIButton = UIButton(type: .custom)
    let NewButton: UIButton = UIButton(type: .custom)
    let BadWordsButton: UIButton = UIButton(type: .custom)
    
    func setup(){
        setupLexiconButton()
        setupNewStartButton()
        setupBadWordsButtonButton()
    }
    
    @objc func onStartButtonTap() {
        OutletsStartActions.shared.startButtonAction()
    }
    
    @objc func onLexiconButtonTap() {
        OutletsStartActions.shared.lexiconButtonAction()
    }
    
    @objc func onBadWordsButtonTap() {
        OutletsStartActions.shared.badWordsButtonAction()
    }
    
    func setupNewStartButton(){
        guard let superView = SelfView else {return}
        superView.addSubview(NewButton)
        NewButton.translatesAutoresizingMaskIntoConstraints = false
        NewButton.centerYAnchor.constraint(equalTo: Lexicon.topAnchor, constant: -50).isActive = true
        NewButton.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        NewButton.setTitle("Start New", for: .normal)
        NewButton.setTitleColor(UIColor(red:0.34, green:0.29, blue:0.56, alpha:1.0), for: .normal)
        NewButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        NewButton.layer.cornerRadius = 5
        NewButton.addTarget(self, action:  Selector(("onStartButtonTap")), for: .touchUpInside)
    }
    

    func setupLexiconButton(){
        guard let superView = SelfView else {return}
        superView.addSubview(Lexicon)
        Lexicon.translatesAutoresizingMaskIntoConstraints = false
        Lexicon.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        Lexicon.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        Lexicon.setTitle("Lexicon", for: .normal)
        Lexicon.setTitleColor(UIColor(red:0.34, green:0.29, blue:0.56, alpha:1.0), for: .normal)
        Lexicon.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        Lexicon.layer.cornerRadius = 5
        Lexicon.addTarget(self, action:  Selector(("onLexiconButtonTap")), for: .touchUpInside)
    }
    
    func setupBadWordsButtonButton(){
        guard let superView = SelfView else {return}
        superView.addSubview(BadWordsButton)
        BadWordsButton.translatesAutoresizingMaskIntoConstraints = false
        BadWordsButton.centerYAnchor.constraint(equalTo: Lexicon.bottomAnchor, constant: 40).isActive = true
        BadWordsButton.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        BadWordsButton.setTitle("Problem Words", for: .normal)
        BadWordsButton.setTitleColor(UIColor(red:0.34, green:0.29, blue:0.56, alpha:1.0), for: .normal)
        BadWordsButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        BadWordsButton.layer.cornerRadius = 5
        BadWordsButton.addTarget(self, action:  Selector(("onBadWordsButtonTap")), for: .touchUpInside)
    }

    
}
