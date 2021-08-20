//
//  ContentView.swift
//  LesB0ules
//
//  Created by lois guillet on 18/08/2021.
//

import SwiftUI

struct ContentView: View {
    var model = ViewModelPhone()
        @State var reachable = "No"
        @State var messageText = ""
        var body: some View {
            VStack{
                Text("Reachable \(reachable)")
                
                Button(action: {
                    if self.model.session.isReachable{
                        self.reachable = "Yes"
                    }
                    else{
                        self.reachable = "No"
                    }
                    
                }) {
                    Text("Update")
                }
                TextField("Input your message", text: $messageText)
                Button(action: {
                    self.model.session.sendMessage(["message" : self.messageText], replyHandler: nil) { (error) in
                        print(error.localizedDescription)
                    }
                    let jsonEncoder = JSONEncoder()
                    var data:Data
                    var dataString:String
                    do{
                        data = try jsonEncoder.encode(self.model.parties)
                        dataString = String(data: data, encoding: String.Encoding.utf16) ?? "vide"
                    }catch{
                        dataString = "vide"
                        print("erreur lors de la converision: \(error)")
                    }
                    self.model.session.sendMessage(["parties" : dataString],  replyHandler: nil) {
                         (error) in
                        print(error.localizedDescription)
                    }
                }) {
                Text("Send Message")
                }
                PartieList(parties: model.parties)
            }
            
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
