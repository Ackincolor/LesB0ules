//
//  ScoreController.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 20/08/2021.
//

import SwiftUI

struct ScoreController: View {
    @StateObject var partie: Game
    var body: some View {
        HStack{
            VStack{
                //scoreController
                //btn
                Button(action:{
                    //ajout a l'equipe 1
                    self.partie.setValue((self.partie.scoreE1+1) , forKey: "scoreE1")
                    self.partie.updatedDate = Date()
                    if(self.partie.scoreE1 >= 13)
                    {
                        //gagné
                    }
                    PersistenceController.shared.save()
                }){
                    Image(systemName: "plus.circle")
                }
                //score
                Text("\(self.partie.scoreE1)")
                
                //btn
                Button(action:{
                    //retrait a l'equipe 1
                    self.partie.scoreE1 -= 1
                    self.partie.updatedDate = Date()
                    PersistenceController.shared.save()
                }){
                    Image(systemName: "minus.circle")
                }
            }
            VStack{
                //scoreController
                //btn
                Button(action:{
                    self.partie.scoreE2 += 1
                    self.partie.updatedDate = Date()
                    PersistenceController.shared.save()
                }){
                    Image(systemName: "plus.circle")
                }
                //score
                Text("\(self.partie.scoreE2)")
                
                //btn
                Button(action:{
                    self.partie.scoreE2 -= 1
                    self.partie.updatedDate = Date()
                    PersistenceController.shared.save()
                }){
                    Image(systemName: "minus.circle")
                }
            }
        }
    }
}

//struct ScoreController_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreController(partie: PartieBoules(nom: "testDetail"))
//    }
//}
