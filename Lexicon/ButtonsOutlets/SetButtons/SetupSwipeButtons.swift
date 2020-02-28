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
    
    func setup(){
        mainWord.text = SwipeDataModel.shared.getNextWord()
        setupMainWordLabel()
        setupFilterButton()
        setupIndexLabel()
    }
    
    func setupMainWordLabel(){
        guard let swipeView = selfView else {return}
        swipeView.addSubview(mainWord)
        mainWord.translatesAutoresizingMaskIntoConstraints = false
        mainWord.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: 0).isActive = true
        mainWord.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        changScale()
        mainWord.sizeToFit()
    }
    
    func changScale(){
        guard let swipeView = selfView else {return}
        let scale = Int(swipeView.bounds.width * 1.6)
        var count = mainWord.text?.count ?? 100
        if count < 12 {count = 12}
        let sscale = scale/(count)
        mainWord.font = .systemFont(ofSize: CGFloat(sscale), weight: .bold)
    }
    
    func reloadWithNewWord(){
        var frame = self.mainWord.frame
                frame.origin.y = 0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.mainWord.frame = frame
                })
        mainWord.text = SwipeDataModel.shared.getNextWord()
        indexLabel.text = "total left \(SwipeDataModel.shared.array.count) words"
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
        indexLabel.text = "total left \(SwipeDataModel.shared.array.count) words"
        
    }
    
}
