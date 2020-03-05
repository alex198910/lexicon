//
//  CoreDataManager.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager {

    static let shared = CoreDataManager()
    
    private var exchangeList = [dictionary]()
    
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AllWordsModel")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy private var managedContextOfProblemWords: NSManagedObjectContext = persistentContainer.viewContext
    lazy private var managedContextOfLexiconWords: NSManagedObjectContext = persistentContainer.viewContext
    
    
    func addLexicon(listOflexiconWords: [dictionary]){
        exchangeList = listOflexiconWords
        addWordsToCoreData(context: managedContextOfLexiconWords, entityName: "LexiconWords")
    }
    
    func addProblemWords(listOfProblemWords: [dictionary]){
        exchangeList = listOfProblemWords
        addWordsToCoreData(context: managedContextOfProblemWords, entityName: "ProblemWords")
    }
    
    private func addWordsToCoreData(context: NSManagedObjectContext, entityName: String){
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {return}
        recordingToContext(entity: entity, context: context)
        savingContext(context: context)
    }
    
    
    private func recordingToContext(entity: NSEntityDescription, context: NSManagedObjectContext){
        switch context{
        case managedContextOfLexiconWords:
            exchangeList.forEach({ body in
                let element = LexiconWords(entity: entity, insertInto: context)
                element.word = body.word
                element.translation = body.translation
            })
        case managedContextOfProblemWords:
            exchangeList.forEach({ body in
                let element = ProblemWords(entity: entity, insertInto: context)
                element.word = body.word
                element.translation = body.translation
            })
        default:
            return
        }
    }
    
    
    private func savingContext(context: NSManagedObjectContext){
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func loadLexiconWords()-> [dictionary]{
        var lexicon = [LexiconWords]()
        var result = [dictionary]()
        let fetch = LexiconWords.fetchRequestLW()
        do {
            lexicon = try managedContextOfLexiconWords.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        lexicon.forEach({ body in
            let element = dictionary.init(word: body.word, translation: body.translation)
            result.append(element)
        })
        return(result)
    }
    
    func loadProblemWords()-> [dictionary]{
        var problem = [ProblemWords]()
        var result = [dictionary]()
        let fetch = ProblemWords.fetchRequestPW()
        do {
            problem = try managedContextOfProblemWords.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        problem.forEach({ body in
            let element = dictionary.init(word: body.word, translation: body.translation)
            result.append(element)
        })
        return(result)
    }
    
    func cleanLexiconWords(){
        var lexicon = [LexiconWords]()
        let fetch = LexiconWords.fetchRequestLW()
        do {
            lexicon = try managedContextOfLexiconWords.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var i = (lexicon.count) - 1
        while (i >= 0) {
            managedContextOfLexiconWords.delete(lexicon[i])
            i -= 1
        }
        savingContext(context: managedContextOfLexiconWords)
    }
    
    func cleanProblemWords(){
        var problem = [ProblemWords]()
        let fetch = ProblemWords.fetchRequestPW()
        do {
            problem = try managedContextOfProblemWords.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var i = (problem.count) - 1
        while (i >= 0) {
            managedContextOfProblemWords.delete(problem[i])
            i -= 1
        }
        savingContext(context: managedContextOfProblemWords)
    }
    
    func deleteOneProblemWord(_ index: Int){
        var problem = [ProblemWords]()
        let fetch = ProblemWords.fetchRequestPW()
        do {
            problem = try managedContextOfProblemWords.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        managedContextOfProblemWords.delete(problem[index])
        savingContext(context: managedContextOfProblemWords)
    }
    
    func deleteOneLexiconWord(_ index: Int){
        var lexicon = [LexiconWords]()
        let fetch = LexiconWords.fetchRequestLW()
        do {
            lexicon = try managedContextOfLexiconWords.fetch(fetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        managedContextOfLexiconWords.delete(lexicon[index])
        savingContext(context: managedContextOfLexiconWords)
    }
    
}
