//
//  ViewModelIphone.swift
//  LesB0ules
//
//  Created by lois guillet on 18/08/2021.
//

import Foundation
import WatchConnectivity
import CoreData
import SwiftUI

class ViewModelPhone : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    
    var parties: [PartieBoules]
    var managedObjectContext = PersistenceController.shared.container.viewContext
    let jsonEncoder = JSONEncoder()
    
    init(session: WCSession = .default){
        self.session = session
        //remplissage d'un liste de partie
        self.parties = [
            PartieBoules(nom: "test1save"),
            PartieBoules(nom: "Test2save")
        ]
        
        super.init()
        self.session.delegate = self
        self.managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        self.session.activate()
        
        let sync = DispatchQueue.init(label: "sync_watch")
        sync.async {
            //lauch sync every 10 seconds
            if(self.session.isReachable){
                self.session.sendMessage(["sync" : "true"], replyHandler: nil) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activation de la session et sync")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("message recu from watch")
        DispatchQueue.main.async {
            let tempMes = message["partiessyncw"] as? String ?? nil
            if(tempMes != nil) {
                let tmp_parties = try! JSONDecoder().decode([PartieBoules].self, from: tempMes!.data(using: .utf8)!)
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
                        do{
                            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
                            let fetchedData = try self.managedObjectContext.fetch(fetchRequest) as! [Game]
                            var toSend:[PartieBoules] = []
                            for game in fetchedData {
                                toSend.append(PartieBoules.init(from: game))
                            }
                            let data = try self.jsonEncoder.encode(toSend)
                            let dataString = String(data: data, encoding: String.Encoding.utf8) ?? "vide"
                            self.session.sendMessage(["partiessynci" : dataString],  replyHandler: nil) {
                                 (error) in
                                print(error.localizedDescription)
                            }
                        }catch{
                            print("erreur lors du fetch : \(error.localizedDescription)")
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }    
}
