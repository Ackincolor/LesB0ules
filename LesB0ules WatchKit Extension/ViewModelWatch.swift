//
//  ViewModelWatch.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 18/08/2021.
//

import Foundation
import WatchConnectivity

class ViewModelWatch : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    @Published var messageText = "test"
    @Published var parties: [PartieBoules]
    init(session: WCSession = .default){
        self.session = session
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
                self.messageText = tempMes ?? ""
            }
            //traitement des données des parties
            let partiesData = message["parties"] as? Data ?? nil
            if(partiesData != nil) {
                self.parties = try! JSONDecoder().decode([PartieBoules].self, from: partiesData ?? Data())
            }
        }
    }
    
}
