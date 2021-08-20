//
//  PartieBoules.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import Foundation


struct PartieBoules : Hashable, Codable, Identifiable{
    var id = UUID()
    var nom: String
    var date: Date
    var participants:[Joueur]
    var equipe1:[Joueur]
    var equipe2:[Joueur]
    var scoreE1:Int
    var scoreE2:Int
    
    //let dateFormatter = DateFormatter()
    
    init(nom: String){
        self.date = Date()
        self.nom = "Partie " + nom
        self.participants = [
            Joueur(prenom: "testDetail1"),
            Joueur(prenom: "testDetail2")
        ]
        equipe1 = [self.participants[0]]
        equipe2 = [self.participants[1]]
        scoreE1 = 4
        scoreE2 = 9
    }
    
}
