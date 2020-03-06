//
//  SetupSwipeButtons.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit



class SetupSwipeButtons {
    static let shared = SetupSwipeButtons()
    
    var selfView: UIView?
    var mainWord = UILabel()
    var superIndex = 0
    var filterButton = UIButton(type: .custom)
    var indexLabel = UILabel()
    var mainWordButton = UIButton(type: .custom)
    
    func setup(){
        mainWord.text = SwipeDataModel.shared.getNextWord()
        setupMainWordLabel()
        setupFilterButton()
        setupIndexLabel()
        setupMainWordButton()
    }
    
    func setupMainWordButton(){
        guard let swipeView = selfView else {return}
        swipeView.addSubview(mainWordButton)
        mainWordButton.translatesAutoresizingMaskIntoConstraints = false
        mainWordButton.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: 0).isActive = true
        mainWordButton.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        mainWordButton.setTitle(mainWord.text, for: .normal)
        mainWordButton.setTitleColor(.black, for: .normal)
    }
    
    func setupMainWordLabel(){
        guard let swipeView = selfView else {return}
        swipeView.addSubview(mainWord)
        mainWord.translatesAutoresizingMaskIntoConstraints = false
        mainWord.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: 0).isActive = true
        mainWord.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        changScale()
        mainWord.sizeToFit()
        mainWord.textColor = UIColors.shared.getBackgroundColour()
    }
    
    func changScale(){
        guard let swipeView = selfView else {return}
        let scale = Int(swipeView.bounds.width * 1.6)
        var count = mainWord.text?.count ?? 100
        if count < 12 {count = 12}
        let sscale = scale/(count)
        mainWord.font = .systemFont(ofSize: CGFloat(sscale), weight: .bold)
        mainWordButton.titleLabel?.font = .systemFont(ofSize: CGFloat(sscale), weight: .bold)
    }
    
    func reloadWithOldWord(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.mainWordButton.frame = self.mainWordButton.frame.offsetBy(dx: 0, dy: 500)
                })
        mainWord.text = SwipeDataModel.shared.getNextWord()
        mainWordButton.setTitle(mainWord.text, for: .normal)
        indexLabel.text = "total left \(SwipeDataModel.shared.array.count) words (word \(SwipeDataModel.shared.index + 1))"
        changScale()
    }
    
    func reloadWithNewWord(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
             self.mainWordButton.frame = self.mainWordButton.frame.offsetBy(dx: 0, dy: -500)
                })
        mainWord.text = SwipeDataModel.shared.getNextWord()
        mainWordButton.setTitle(mainWord.text, for: .normal)
        indexLabel.text = "total left \(SwipeDataModel.shared.array.count) words (word \(SwipeDataModel.shared.index + 1))"
        changScale()
    }
    
    func setupFilterButton(){
        guard let swipeView = selfView else {return}
        swipeView.addSubview(filterButton)
        filterButton.backgroundColor = UIColors.shared.getTextColour()
        filterButton.setTitle(" Filter use Lexicon ", for: .normal)
        filterButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        filterButton.titleLabel?.numberOfLines = 0
        filterButton.titleLabel?.textAlignment = .center
        filterButton.layer.cornerRadius = 10
        filterButton.titleLabel?.textColor = .white
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.centerYAnchor.constraint(equalTo: swipeView.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        filterButton.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        filterButton.addTarget(self, action:  Selector(("filterButtonAction")), for: .touchUpInside)
    }
    
    @objc func filterButtonAction(){
        OutletsSwipeActions.shared.filterButton()
     }
    
    func setupIndexLabel(){
        guard let swipeView = selfView else {return}
        swipeView.addSubview(indexLabel)
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.centerYAnchor.constraint(equalTo: swipeView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        indexLabel.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        indexLabel.textColor = UIColors.shared.getTextColour()
        indexLabel.text = "total left \(SwipeDataModel.shared.array.count) words (word \(SwipeDataModel.shared.index + 1))"
        
    }
    
}
