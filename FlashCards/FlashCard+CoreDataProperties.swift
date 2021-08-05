//
//  FlashCard+CoreDataProperties.swift
//  FlashCards
//
//  Created by Bubbly Boey on 15/05/21.
//
//

import Foundation
import CoreData


extension FlashCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?

}

extension FlashCard : Identifiable {

}
