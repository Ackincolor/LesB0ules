//
//  PartieList.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI

struct PartieList: View {
    let parties: FetchedResults<Game>
    
    var body: some View {
        NavigationView{
            List(parties){ _partie in
                NavigationLink(destination: PartieDetail(partie: _partie)){
                    PartieRow(partie: _partie)
                }
            }
            .navigationTitle("Parties")
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
