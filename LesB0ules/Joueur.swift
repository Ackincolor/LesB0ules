//
//  Joueurs.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import Foundation

struct Joueur : Hashable, Codable, Identifiable{
    var id = UUID()
    var prenom: String
    var boules: Int
    init(prenom: String) {
        self.prenom = prenom
        self.boules = 1
    }
}
