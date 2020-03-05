//
//  WordsManager.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Работает со строкой, вставленной пользователем. Валидирует ее и делит на отдельные слова, удаляет повторные.

class WordsManager {
    
    static let shared = WordsManager()
    
    func words(_ s: String)->[String]{
        var allWords = [String]()
        allWords = s.components(separatedBy: " ")
        allWords.sort()
        allWords = deleteGarbage(allWords)
        allWords = removeDupl(allWords)
        allWords.sort()
        allWords = removeDupl(allWords)
        return (allWords)
    }
    
    func deleteGarbage(_ x: [String]) -> [String] {
        var superx = x
        var i = 0
        while i < superx.count  {
            superx[i] = superx[i].lowercased()
            validateWord(&superx[i])
            if superx[i].count == 0 {superx.remove(at: i)}
            else {i += 1}
        }
        
        return (superx)
    }
    
    func validateWord(_ str: inout String){
        while (str.count != 0 && (str.first?.asciiValue ?? 1 < UInt8(97) ||
                str.first?.asciiValue ?? 199 > UInt8(122))) {
                    str.removeFirst()
        }
        while (str.count != 0 && (str.last?.asciiValue ?? 1 < UInt8(97) ||
                str.last?.asciiValue ?? 199 > UInt8(122))) {
                    str.removeLast()
        }
    }
    
    func removeDupl <T: Equatable> (_ x: [T])-> [T] {
        var superx = x
        var i = 0
        while i < superx.count - 1 {
            if (superx[i] == superx[i+1]){
                superx.remove(at: i + 1)
            }
            else { i = i + 1}
        }
        
        return (superx)
    }
    
}
