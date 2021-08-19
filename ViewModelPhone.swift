//
//  ViewModelIphone.swift
//  LesB0ules
//
//  Created by lois guillet on 18/08/2021.
//

import Foundation
import WatchConnectivity

class ViewModelPhone : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    var parties: [PartieBoules]
    init(session: WCSession = .default){
        self.session = session
        //remplissage d'un liste de partie
        self.parties = [
            PartieBoules(nom: "test1"),
            PartieBoules(nom: "Test2")
        ]
        
        super.init()
        self.session.delegate = self
        self.session.activate()
        
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}
