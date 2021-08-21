//
//  Joueurs.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import Foundation
import CoreData

struct Joueur : Hashable, Codable, Identifiable{
    var id: UUID
    var prenom: String
    var boules: Int
    init(prenom: String, id: UUID) {
        self.prenom = prenom
        self.boules = 1
        self.id = id
    }
    
    init(from: Person){
        self.id = from.id!
        self.prenom = from.prenom!
        self.boules = Int(from.boules)
    }
    
    func toPerson(managedObjectContext: NSManagedObjectContext) -> Person {
        var tmp = Person(context: managedObjectContext)
        tmp.id = self.id
        tmp.prenom = self.prenom
        tmp.boules = Int16(self.boules)
        return tmp
    }
}
