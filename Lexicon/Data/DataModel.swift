//
//  DataModel.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

// Управляет данными

struct dictionary {
    var word: String?
    var translation: String?
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
        Data.addLexicon(listOflexiconWords: lexicon)
    }
    
    // Вызывает метод сохранения в  CoreData переданных в нее проблемных слов
    private func saveProblemWords(problemWords: [dictionary]){
         Data.addProblemWords(listOfProblemWords: problemWords)
    }
    
    // Получает массивы лексикона и проблемных слов, преобразует формат и вызывает сохранение в CoreData
    func saveFromSwipeController(_ lexicon: [String], _ problem: [String]){
        var good = [dictionary]()
        var bad = [dictionary]()
        lexicon.forEach({body in
            good.append(dictionary.init(word: body, translation: ""))
        })
        problem.forEach({body in
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
    
    func getFilterProblemWords(_ text: [String])-> [String]{
        var newString = [String]()
        let lexiconFromCoreData = convertDictionaryToString(getLexiconWords())
        text.forEach({body in
            if lexiconFromCoreData.contains(body){}
            else {newString.append(body)}
        })
        
        return newString
    }
    
}
