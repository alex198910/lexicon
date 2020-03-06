//
//  DataModel.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Управляет данными

struct dictionary: Comparable {
    var word: String?
    var translation: String?
    
    static func < (lhs: dictionary, rhs: dictionary) -> Bool {
        let l: String = lhs.word ?? ""
        let p: String = rhs.word ?? ""
        return l < p
        }
}

class DataModel {
    static let shared = DataModel()
    let Data = CoreDataManager.shared
    let WordsData = WordsManager.shared
    
    var stringFromTextField: String?
    
    // Преобразует стартовую строку в отдельные символы, проводит валидацию
    func getTextFieldData()->[String]{
        guard let result = stringFromTextField else {return []}
        return WordsData.words(result)
    }
    
    // Возвращает лексикон из CoreData
    func getLexiconWords()->[dictionary]{
        var result = [dictionary]()
        result = Data.loadLexiconWords()
        
        return(result)
    }
    
    // Возвращает проблемные слова из CoreData
    func getProblemWords()->[dictionary]{
        var result = [dictionary]()
        result = Data.loadProblemWords()
        
        return(result)
    }
    
    // Вызывает метод сохранения в  CoreData переданного в нее лексикона
    private func saveNewLexicon(lexicon: [dictionary]){
        let lex = filterDictionary(toSave: lexicon, coreData: getLexiconWords())
        Data.addLexicon(listOflexiconWords: lex)
    }
    
    // Вызывает метод сохранения в  CoreData переданных в нее проблемных слов
    private func saveProblemWords(problemWords: [dictionary]){
        let problem = filterDictionary(toSave: problemWords, coreData: getProblemWords())
        Data.addProblemWords(listOfProblemWords: problem)
    }
    
    // Получает массивы лексикона и проблемных слов, преобразует формат и вызывает сохранение в CoreData
    func saveFromSwipeController(_ lexicon: [String], _ problem: [String]){
        var good = [dictionary]()
        var bad = [dictionary]()
        let lex = lexicon.sorted()
        let prob = problem.sorted()
        lex.forEach({body in
            good.append(dictionary.init(word: body, translation: ""))
        })
        prob.forEach({body in
            bad.append(dictionary.init(word: body, translation: ""))
        })
        saveNewLexicon(lexicon: good)
        saveProblemWords(problemWords: bad)
    }
    
    // Преобразует [String] в [dictionary]
    func convertStringToDictionary(_ text: [String])-> [dictionary]{
        var newDictionary = [dictionary]()
        text.forEach({body in
            newDictionary.append(dictionary.init(word: body, translation: ""))
        })
        return (newDictionary)
    }
    
    // Преобразует  [dictionary] в [String]
    func convertDictionaryToString(_ text: [dictionary])-> [String]{
        var newString = [String]()
        text.forEach({body in
            newString.append(body.word ?? "")
        })
        return (newString)
    }
    
    
    // Возвращает отфильтрованную строку 
    func getFilterProblemWords(_ text: [String])-> [String]{
        var newString = [String]()
        let lexiconFromCoreData = convertDictionaryToString(getLexiconWords())
        text.forEach({body in
            if lexiconFromCoreData.contains(body){}
            else {newString.append(body)}
        })
        
        return newString
    }
    
    // удаляет одно слово из CoreData  по Index
    func deleteWord(index: Int, source: String){
        if source == "lexicon" {
            Data.deleteOneLexiconWord(index)
        }
        if source == "problem" {
            Data.deleteOneProblemWord(index)
        }
    }
    
    //  возвращает отфильтрованный массив слов (из переданных, отсутствующих в CoreData)
    func filterDictionary(toSave: [dictionary], coreData: [dictionary])->[dictionary]{
        var newDictionary = [dictionary]()
        let coreDataString = convertDictionaryToString(coreData)
        toSave.forEach({body in
            if coreDataString.contains(body.word ?? ""){}
            else {newDictionary.append(body) }
        })
        return(newDictionary)
    }
    
    
    func deleteDoublersInCoreData()
    {
        let reserveLexicon = getLexiconWords()
        let reserveProblem = getProblemWords()
        Data.cleanLexiconWords()
        Data.cleanProblemWords()
        saveNewLexicon(lexicon: reserveLexicon)
        saveProblemWords(problemWords: reserveProblem)
    }
    
//    func sortDictionary(toSort: [dictionary])-> [dictionary]{
//        let newDictionary = [dictionary]()
//        return newDictionary
//    }
    
}
