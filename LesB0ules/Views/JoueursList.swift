//
//  JoueursList.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI

struct JoueursList: View {
    let joueurs: [Joueur]
    
    var body: some View {
        NavigationView{
            List(joueurs){ _joueur in
                NavigationLink(destination: JoueurDetail(joueur: _joueur)){
                    JoueurRow(joueur: _joueur)
                }
            }
        }
    }
}

struct JoueursList_Previews: PreviewProvider {
    static var previews: some View {
        JoueursList(joueurs: [
            Joueur(prenom: "bob3"),
            Joueur(prenom: "bob4")
        ])
    }
}
