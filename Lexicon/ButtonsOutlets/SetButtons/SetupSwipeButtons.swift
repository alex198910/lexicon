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
    
    var SelfView: UIView?
    var MainWord = UILabel()
    var superIndex = 0
    var FilterButton = UIButton(type: .custom)
    var IndexLabel = UILabel()
    var MainWordButton = UIButton(type: .custom)
    
    func setup(){
        MainWord.text = SwipeDataModel.shared.getNextWord()
        setupMainWordLabel()
        setupFilterButton()
        setupIndexLabel()
        setupMainWordButton()
    }
    
    func setupMainWordButton(){
        guard let swipeView = SelfView else {return}
        swipeView.addSubview(MainWordButton)
        MainWordButton.translatesAutoresizingMaskIntoConstraints = false
        MainWordButton.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: 0).isActive = true
        MainWordButton.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        MainWordButton.setTitle(MainWord.text, for: .normal)
        MainWordButton.setTitleColor(.black, for: .normal)
    }
    
    func setupMainWordLabel(){
        guard let swipeView = SelfView else {return}
        swipeView.addSubview(MainWord)
        MainWord.translatesAutoresizingMaskIntoConstraints = false
        MainWord.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: 0).isActive = true
        MainWord.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        changScale()
        MainWord.sizeToFit()
        MainWord.textColor = UIColors.shared.getBackgroundColour()
    }
    
    func changScale(){
        guard let swipeView = SelfView else {return}
        let scale = Int(swipeView.bounds.width * 1.6)
        var count = MainWord.text?.count ?? 100
        if count < 12 {count = 12}
        let sscale = scale/(count)
        MainWord.font = .systemFont(ofSize: CGFloat(sscale), weight: .bold)
        MainWordButton.titleLabel?.font = .systemFont(ofSize: CGFloat(sscale), weight: .bold)
    }
    
    func reloadWithOldWord(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.MainWordButton.frame = self.MainWordButton.frame.offsetBy(dx: 0, dy: 500)
                })
        MainWord.text = SwipeDataModel.shared.getNextWord()
        MainWordButton.setTitle(MainWord.text, for: .normal)
        IndexLabel.text = "total left \(SwipeDataModel.shared.array.count) words (word \(SwipeDataModel.shared.index + 1))"
        changScale()
    }
    
    func reloadWithNewWord(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
             self.MainWordButton.frame = self.MainWordButton.frame.offsetBy(dx: 0, dy: -500)
                })
        MainWord.text = SwipeDataModel.shared.getNextWord()
        MainWordButton.setTitle(MainWord.text, for: .normal)
        IndexLabel.text = "total left \(SwipeDataModel.shared.array.count) words (word \(SwipeDataModel.shared.index + 1))"
        changScale()
    }
    
    func setupFilterButton(){
        guard let swipeView = SelfView else {return}
        swipeView.addSubview(FilterButton)
        FilterButton.backgroundColor = UIColors.shared.getTextColour()
        FilterButton.setTitle(" Filter use Lexicon ", for: .normal)
        FilterButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        FilterButton.titleLabel?.numberOfLines = 0
        FilterButton.titleLabel?.textAlignment = .center
        FilterButton.layer.cornerRadius = 10
        FilterButton.titleLabel?.textColor = .white
        FilterButton.translatesAutoresizingMaskIntoConstraints = false
        FilterButton.centerYAnchor.constraint(equalTo: swipeView.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        FilterButton.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        FilterButton.addTarget(self, action:  Selector(("filterButtonAction")), for: .touchUpInside)
    }
    
    @objc func filterButtonAction(){
        OutletsSwipeActions.shared.filterButton()
     }
    
    func setupIndexLabel(){
        guard let swipeView = SelfView else {return}
        swipeView.addSubview(IndexLabel)
        IndexLabel.translatesAutoresizingMaskIntoConstraints = false
        IndexLabel.centerYAnchor.constraint(equalTo: swipeView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        IndexLabel.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor, constant: 0).isActive = true
        IndexLabel.textColor = UIColors.shared.getTextColour()
        IndexLabel.text = "total left \(SwipeDataModel.shared.array.count) words (word \(SwipeDataModel.shared.index + 1))"
        
    }
    
}
