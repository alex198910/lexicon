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
    var selfView: UIView?
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
}
