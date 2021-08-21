//
//  ViewModelWatch.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 18/08/2021.
//

import Foundation
import WatchConnectivity
import CoreData

class ViewModelWatch : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    @Published var messageText = "test"
    @Published var parties: [Game]
    var managedObjectContext = PersistenceController.shared.container.viewContext
    init(session: WCSession = .default){
        
        self.session = session
//        self.parties = [
//            PartieBoules(nom: "test1fromwatch"),
//            PartieBoules(nom: "Test2fromwatch")
//        ]
        self.parties = []
        super.init()
        self.session.delegate = self
        session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("message recu")
        DispatchQueue.main.async {
            
            let tempMes = message["message"] as? String ?? nil
            if(tempMes != nil) {
                if(tempMes=="sync"){
                    //sync to Iphone
                    //fetchData
                    do{
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
                        var fetchedData = try self.managedObjectContext.fetch(fetchRequest) as! [Game]
                        var toSend:[PartieBoules] = []
                        for game in fetchedData {
                            toSend.append(PartieBoules.init(from: game))
                        }
                        
                    }catch{
                        print("erreur lors du fetch : \(error.localizedDescription)")
                    }
                }else{
                    self.messageText = tempMes ?? ""
                }
            }
            //traitement des données des parties
            let partiesData = message["parties"] as? String ?? ""
            //print (partiesData)
            if(partiesData != "") {
                var tmp_parties = try! JSONDecoder().decode([PartieBoules].self, from: partiesData.data(using: .utf8)!)
                //utilisation d'une class tempon
                for game in tmp_parties {
                    do{
                        self.parties.append(game.toGame(managedObjectContext: self.managedObjectContext))
                        try self.managedObjectContext.save()
                        print("save \(game.nom)")
                    }catch{
                        print("erreur de save : \(error.localizedDescription)")
                    }
                }
            }
            //print(self.parties)
        }
        PersistenceController.shared.save()
    }
}
