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
                        var toCompare:[PartieBoules] = []
                        for game in fetchedData {
                            toCompare.append(PartieBoules.init(from: game))
                        }
                        if(!toCompare.isEmpty){
                            let more_recent = game.updatedDate > toCompare[0].updatedDate ? true : false
                            if(more_recent)
                            {
                                print("Updating : \(game.id)")
                                
                            }else{
                                print("not updating : \(game.id)")
                            }
                        }else{
                            //insert
                            
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }    
}
