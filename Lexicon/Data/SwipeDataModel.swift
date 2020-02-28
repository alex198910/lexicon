//
//  SwipeDataModel.swift
//  Lexicon
//
//  Created by admin on 28.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class SwipeDataModel {
    static let shared = SwipeDataModel()
    
    var array = [String]()
    var problemWords = [String]()
    var lexiconWords = [String]()
    private var index = 0
    var filterIndex = 0
    func reset(){
        array.removeAll()
        problemWords.removeAll()
        lexiconWords.removeAll()
        index = 0
    }
    
    func getNextWord()-> String {
        guard array.count > 0 else {
            saveToCoreData()
            return ""
        }
        let word = array[index]
        return (word)
    }
    
    func addWordToLexicon(){
        guard array.count > 0 else {
            return
        }
        lexiconWords.append(array[index])
        array.remove(at: index)
        changeIndexAfterRemoving()
    }
    
    func addWordToProblem(){
        guard array.count > 0 else {
            return
        }
        problemWords.append(array[index])
        array.remove(at: index)
        changeIndexAfterRemoving()
    }
    
    func changeIndexManual(){
        if index < array.count - 1 {
            index += 1
        }
        else {index = 0}
    }
    
    func changeIndexManualBack(){
        if index > 0 {
            index -= 1
        }
        else {index = array.count - 1}
    }
    
    private func changeIndexAfterRemoving(){
        if index > array.count - 1 {
            index = 0
        }
    }
    
    func saveToCoreData(){
        DataModel.shared.saveFromSwipeController(lexiconWords, problemWords)
    }
    
    func isFinished()->Bool {
        guard array.count > 0 else {return true}
        return false
    }
    
    func filterAllWords(){
        array = DataModel.shared.getFilterProblemWords(array)
        filterIndex += 1
    }
    
}
