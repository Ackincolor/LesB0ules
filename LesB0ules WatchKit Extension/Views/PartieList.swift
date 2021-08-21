//
//  PartieList.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 20/08/2021.
//

import SwiftUI

struct PartieList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    let parties: FetchedResults<Game>
    
    var body: some View {
//        Button(action: {
//            var tmp = PartieBoules(nom: "test Insert")
//            tmp.id = UUID()
//            tmp.scoreE1 = 13
//            tmp.toGame(managedObjectContext: managedObjectContext)
//            PersistenceController.shared.save()
//            print("Insert Game into Watch")
//        }){
//            Text("AddGame")
//        }
            List(parties){ _partie in
                NavigationLink(destination: PartieDetail(partie: _partie)) {
                    PartieRow(partie: _partie)
                }
        }
    }
}

//struct PartieList_Previews: PreviewProvider {
//    static var previews: some View {
//        PartieList(parties: [
//            PartieBoules(nom: "test1"),
//            PartieBoules(nom: "Test2")
//        ])
//    }
//}
