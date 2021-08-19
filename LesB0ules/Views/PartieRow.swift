//
//  PartieRow.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI

struct PartieRow: View {
    var partie: PartieBoules
    var body: some View {
        HStack{
            Text(partie.nom)
        }
    }
}

struct PartieRow_Previews: PreviewProvider {
    static var previews: some View {
        PartieRow(partie: PartieBoules(nom: "Test"))
    }
}
