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
    let jsonEncoder = JSONEncoder()
    init(session: WCSession = .default){
        
        self.session = session
//        self.parties = [
//            PartieBoules(nom: "test1fromwatch"),
//            PartieBoules(nom: "Test2fromwatch")
//        ]
        self.parties = []
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            
            let tempMes = message["message"] as? String ?? nil
            let sync = message["sync"] as? String ?? nil
            if(tempMes != nil) {
                    self.messageText = tempMes ?? ""
            }
            print("message recu : \(sync)")
            if(sync != nil){
                //sync to Iphone
                //fetchData
                do{
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
                    let fetchedData = try self.managedObjectContext.fetch(fetchRequest) as! [Game]
                    var toSend:[PartieBoules] = []
                    for game in fetchedData {
                        toSend.append(PartieBoules.init(from: game))
                    }
                    let data = try self.jsonEncoder.encode(toSend)
                    let dataString = String(data: data, encoding: String.Encoding.utf8) ?? "vide"
                    self.session.sendMessage(["partiessyncw" : dataString],  replyHandler: nil) {
                         (error) in
                        print(error.localizedDescription)
                    }
                }catch{
                    print("erreur lors du fetch : \(error.localizedDescription)")
                }
            }
            //traitement des données des parties
            let partiesData = message["parties"] as? String ?? ""
            //print (partiesData)
            if(partiesData != "") {
                let tmp_parties = try! JSONDecoder().decode([PartieBoules].self, from: partiesData.data(using: .utf8)!)
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
            
            
            //sync from iphone
            let dataFromI = message["partiessynci"] as? String ?? nil
            if(dataFromI != nil) {
                let tmp_parties = try! JSONDecoder().decode([PartieBoules].self, from: dataFromI!.data(using: .utf8)!)
                print(tmp_parties)
                for game in tmp_parties {
                    do{
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
                        fetchRequest.predicate = NSPredicate(format:"id == %@",game.id.uuidString)
                        let fetchedData = try self.managedObjectContext.fetch(fetchRequest) as! [Game]
                        var toCompare:[Game] = []
                        for game in fetchedData {
                            toCompare.append(game)
                        }
                        if(!toCompare.isEmpty){
                            let more_recent = game.updatedDate > (toCompare[0].updatedDate)! ? true : false
                            if(more_recent)
                            {
                                print("Updating : \(game.id)")
                                toCompare[0].scoreE1 = Int16(game.scoreE1)
                                toCompare[0].scoreE2 = Int16(game.scoreE2)
                                toCompare[0].updatedDate = game.updatedDate
                                try self.managedObjectContext.save()
                                
                            }else{
                                print("not updating : \(game.id)")
                            }
                        }else{
                            //insert
                            print("Insert : \(game.id)")
                            game.toGame(managedObjectContext: self.managedObjectContext)
                            try self.managedObjectContext.save()
                            
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            //print(self.parties)
        }
        PersistenceController.shared.save()
    }
}
