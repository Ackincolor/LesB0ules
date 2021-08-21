//
//  PartieBoules.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import Foundation
import CoreData

struct PartieBoules : Hashable, Codable, Identifiable{
    var id: UUID
    var nom: String
    var date: Date
    var updatedDate:  Date
    var participants:[Joueur]
    var equipe1:[Joueur]
    var equipe2:[Joueur]
    var scoreE1:Int
    var scoreE2:Int
    
    //let dateFormatter = DateFormatter()
    
    init(nom: String){
        self.date = Date()
        self.updatedDate = Date()
        self.nom = "Partie " + nom
        self.participants = [
            Joueur(prenom: "testDetail1", id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!),
            Joueur(prenom: "testDetail2", id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6EFF")!)
        ]
        equipe1 = [self.participants[0]]
        equipe2 = [self.participants[1]]
        scoreE1 = 4
        scoreE2 = 9
        self.id = UUID()
    }
    init(from: Game){
        self.date = from.date!
        self.nom = from.nom!
        self.participants = []
        for perso in from.participants?.array as! [Person]{
            self.participants.append(Joueur(from:perso))
        }
        self.equipe1 = []
        self.equipe2 = []
        self.scoreE1 = Int(from.scoreE1)
        self.scoreE2 = Int(from.scoreE2)
        self.id = from.id!
        self.updatedDate = from.updatedDate!
    }
    func toGame(managedObjectContext: NSManagedObjectContext) -> Game {
        let game = Game(context: managedObjectContext)
        game.date = self.date
        game.nom = self.nom
        game.scoreE1 = Int16(self.scoreE1)
        game.scoreE2 = Int16(self.scoreE2)
        //creation des 'Person'
        var tmp:[Person] = []
        for perso in self.participants {
            do{
                tmp.append(perso.toPerson(managedObjectContext: managedObjectContext))
                try managedObjectContext.save()
            }catch{
                print("nested error \(error.localizedDescription)")
            }
        }
        game.participants = NSOrderedSet(array: tmp)
//        game.equipe1 = NSOrderedSet(array: self.equipe1)
//        game.equipe2 = NSOrderedSet(array: self.equipe2)
        game.id = self.id
        game.updatedDate = self.updatedDate
        return game
    }
    
}
