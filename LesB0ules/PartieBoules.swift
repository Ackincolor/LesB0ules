//
//  PartieBoules.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import Foundation


struct PartieBoules : Hashable, Codable, Identifiable{
    let id = UUID()
    var nom: String
    var date: Date
    var participants:[Joueur]
    
    //let dateFormatter = DateFormatter()
    
    init(nom: String){
        self.date = Date()
        self.nom = "Partie du " + nom
        self.participants = []
    }
    
}
