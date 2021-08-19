//
//  ViewModelIphone.swift
//  LesB0ules
//
//  Created by lois guillet on 18/08/2021.
//

import Foundation
import WatchConnectivity

class ViewModelPhone : NSObject,  WCSessionDelegate{
    var session: WCSession
    init(session: WCSession = .default){
        self.session = session
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
