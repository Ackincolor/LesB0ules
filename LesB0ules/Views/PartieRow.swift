//
//  PartieRow.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI

struct PartieRow: View {
    var partie: Game
    var body: some View {
        VStack{
            Text(partie.nom!)
            Text(partie.id!.uuidString).font(.system(size: 7))
        }
    }
}
//
//struct PartieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PartieRow(partie: PartieBoules(nom: "Test"))
//    }
//}
