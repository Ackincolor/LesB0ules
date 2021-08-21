//
//  PartieDetail.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI
import CoreData

struct PartieDetail: View {
    var partie: Game
    var body: some View {
        VStack{
            Text("Partie")
            Spacer()
            Text("detail " + partie.nom!)
            JoueursList(joueurs: partie.participants?.array as [Person])
            
        }
    }
}

//struct PartieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PartieDetail(partie: nil)
//    }
//}
