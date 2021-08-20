//
//  JoueurRow.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI

struct JoueurRow: View {
    var joueur: Joueur
    var body: some View {
        HStack{
            Text(joueur.prenom)
        }
    }
}

struct JoueurRow_Previews: PreviewProvider {
    static var previews: some View {
        JoueurRow(joueur: Joueur(prenom: "BobTest"))
    }
}
