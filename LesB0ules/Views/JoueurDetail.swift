//
//  JoueurDetail.swift
//  LesB0ules
//
//  Created by lois guillet on 20/08/2021.
//

import SwiftUI

struct JoueurDetail: View {
    var joueur: Joueur
    var body: some View {
        VStack{
            Text("Joueur")
            Spacer()
            Text("detail \(joueur.prenom)")
            
        }
    }
}

struct JoueurDetail_Previews: PreviewProvider {
    static var previews: some View {
        JoueurDetail(joueur: Joueur(prenom: "JoueurDetail"))
    }
}
