//
//  PartieDetail.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 20/08/2021.
//
import SwiftUI

struct PartieDetail: View {
    var partie: PartieBoules
    var body: some View {
        VStack{
            Text("Partie \(partie.nom)")
            
        }
    }
}

struct PartieDetail_Previews: PreviewProvider {
    static var previews: some View {
        PartieDetail(partie: PartieBoules(nom: "testDetail"))
    }
}
