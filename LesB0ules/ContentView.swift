//
//  ContentView.swift
//  LesB0ules
//
//  Created by lois guillet on 18/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
            entity: Game.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Game.nom, ascending: true)]
        ) var games: FetchedResults<Game>
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedObjectContext.delete(objectData)
                PersistenceController.shared.save()
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    func sync() {
        //try to sync with watch
        if(self.model.session.isReachable){
            self.model.session.sendMessage(["sync" : "true"], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
    }
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
                        var tmp:[PartieBoules] = []
                        for game in self.games {
                            tmp.append(PartieBoules.init(from: game))
                        }
                        data = try jsonEncoder.encode(tmp)
                        dataString = String(data: data, encoding: String.Encoding.utf8) ?? "vide"
                    }catch{
                        dataString = "vide"
                        print("erreur lors de la converision: \(error)")
                    }
                    print(dataString)
                    self.model.session.sendMessage(["parties" : dataString],  replyHandler: nil) {
                         (error) in
                        print(error.localizedDescription)
                    }
                }) {
                Text("Send Message")
                }
                Button(action: {
                    var tmp = PartieBoules(nom: "test Insert for watch")
                    tmp.id = UUID()
                    tmp.scoreE1 = 13
                    tmp.toGame(managedObjectContext: managedObjectContext)
                    PersistenceController.shared.save()
                }){
                    Text("AddGame")
                }
                Button(action: {
                    deleteAllData("Game")
                    deleteAllData("Person")
                }){
                    Text("deleteAll")
                }
                Button(action: {
                    self.sync()
                }){
                    Text("sync")
                }
                PartieList(parties: self.games)
            }
            
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

