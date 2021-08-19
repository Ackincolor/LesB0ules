//
//  PartieBoules.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import Foundation


struct PartieBoules : Hashable, Codable{
    var nom: String
    var date: Date
    var participants:[Joueur]
    
    //let dateFormatter = DateFormatter()
    
//    init(){
//        dateFormatter.dateFormat = "dd/MM/YYYY"
//        self.date = Date()
//        self.nom = "Partie du " + dateFormatter.string(from: self.date)
//        self.participants = []
//    }
    
}
