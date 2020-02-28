//
//  LexiconWords+CoreDataProperties.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//
//

import Foundation
import CoreData


extension LexiconWords {

    @nonobjc public class func fetchRequestLW() -> NSFetchRequest<LexiconWords> {
        return NSFetchRequest<LexiconWords>(entityName: "LexiconWords")
    }

    @NSManaged public var word: String?
    @NSManaged public var translation: String?

}
