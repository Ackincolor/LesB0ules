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
    @Environment(\.managedObjectContext) var managedObjectContext
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
    func sync() {
        //try to sync with watch
        if(session.isReachable){
            self.session.sendMessage(["sync" : "true"], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    
}
