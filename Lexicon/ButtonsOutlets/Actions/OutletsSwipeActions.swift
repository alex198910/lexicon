//
//  OutletsSwipeActions.swift
//  Lexicon
//
//  Created by admin on 28.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

protocol ReloadInputViews {
    func reload()
}

class OutletsSwipeActions {
    static let shared = OutletsSwipeActions()
    weak var selfView: UIView?
    var delegate: ReloadInputViews?
    
    
    func handleSwipe(_ sender: UISwipeGestureRecognizer)
    {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                SwipeDataModel.shared.addWordToProblem()
                reload()
                //selfView?.backgroundColor = .yellow
            case .left:
                SwipeDataModel.shared.addWordToLexicon()
                reload()
                //selfView?.backgroundColor = .yellow
            case .up:
                SwipeDataModel.shared.changeIndexManual()
                reload()
                //selfView?.backgroundColor = .yellow
            case .down:
                SwipeDataModel.shared.changeIndexManualBack()
                reloadBack()
                //selfView?.backgroundColor = .yellow
            default:
                break
            }
            //reload()
        }
    }
    
    func reload(){
        SetupSwipeButtons.shared.reloadWithNewWord()
        delegate?.reload()
    }
    
    func reloadBack(){
        SetupSwipeButtons.shared.reloadWithOldWord()
        delegate?.reload()
    }
    
    func filterButton(){
        if SwipeDataModel.shared.filterIndex == 0 {
        SwipeDataModel.shared.filterAllWords()
        SetupSwipeButtons.shared.reloadWithNewWord()
        delegate?.reload()
        }
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let swipeView = selfView else {return}
        let translation = recognizer.translation(in: swipeView)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: swipeView)
        if recognizer.state == .ended {
            if recognizer.view?.center.x ?? 0 < swipeView.center.x - swipeView.center.x/3 {
                SwipeDataModel.shared.addWordToLexicon()
                reload()
            }
            else if recognizer.view?.center.x ?? 0 > swipeView.center.x + swipeView.center.x/3 {
                    SwipeDataModel.shared.addWordToProblem()
                    reload()
                }
            else if recognizer.view?.center.y ?? 0 < swipeView.center.y - swipeView.center.y/4{
                    SwipeDataModel.shared.changeIndexManual()
                    reload()
                }
            else if recognizer.view?.center.y ?? 0 > swipeView.center.y + swipeView.center.y/4 {
                    SwipeDataModel.shared.changeIndexManualBack()
                    reloadBack()
                }
            else{
                recognizer.view?.center = CGPoint(x: swipeView.center.x, y: swipeView.center.y)
            }
        }
    }
}
