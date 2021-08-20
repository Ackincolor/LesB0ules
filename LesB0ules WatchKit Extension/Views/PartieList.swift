//
//  PartieList.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 20/08/2021.
//

import SwiftUI

struct PartieList: View {
    let parties: [PartieBoules]
    
    var body: some View {
            List(parties){ _partie in
                NavigationLink(destination: PartieDetail(partie: _partie)) {
                    PartieRow(partie: _partie)
                }
        }
    }
}

struct PartieList_Previews: PreviewProvider {
    static var previews: some View {
        PartieList(parties: [
            PartieBoules(nom: "test1"),
            PartieBoules(nom: "Test2")
        ])
    }
}
