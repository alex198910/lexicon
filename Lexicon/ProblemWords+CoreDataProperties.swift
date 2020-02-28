//
//  ProblemWords+CoreDataProperties.swift
//  Lexicon
//
//  Created by admin on 27.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//
//

import Foundation
import CoreData


extension ProblemWords {

    @nonobjc public class func fetchRequestPW() -> NSFetchRequest<ProblemWords> {
        return NSFetchRequest<ProblemWords>(entityName: "ProblemWords")
    }

    @NSManaged public var word: String?
    @NSManaged public var translation: String?

}
