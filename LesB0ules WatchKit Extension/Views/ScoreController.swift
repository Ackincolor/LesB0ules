//
//  ScoreController.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 20/08/2021.
//

import SwiftUI

struct ScoreController: View {
    @State var partie: PartieBoules
    var body: some View {
        HStack{
            VStack{
                //scoreController
                //btn
                Button(action:{
                    //ajout a l'equipe 1
                    self.partie.scoreE1 += 1
                }){
                    Image(systemName: "plus.circle")
                }
                //score
                Text("\(self.partie.scoreE1)")
                
                //btn
                Button(action:{
                    //retrait a l'equipe 1
                    self.partie.scoreE1 -= 1
                }){
                    Image(systemName: "minus.circle")
                }
            }
            VStack{
                //scoreController
                //btn
                Button(action:{
                    self.partie.scoreE2 += 1
                }){
                    Image(systemName: "plus.circle")
                }
                //score
                Text("\(self.partie.scoreE2)")
                
                //btn
                Button(action:{
                    self.partie.scoreE2 -= 1
                }){
                    Image(systemName: "minus.circle")
                }
            }
        }
    }
}

struct ScoreController_Previews: PreviewProvider {
    static var previews: some View {
        ScoreController(partie: PartieBoules(nom: "testDetail"))
    }
}
