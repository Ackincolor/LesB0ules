//
//  ContentView.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 18/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var model = ViewModelWatch()
    
    @FetchRequest(
            entity: Game.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Game.nom, ascending: true)]
        ) var games: FetchedResults<Game>
    var body: some View {
        VStack{
            Button(action: {
                deleteAllData("Game")
            }){
                Image(systemName: "trash")
            }
            NavigationView{
                PartieList(parties: self.games)
            }
            .navigationTitle("Parties")
        }
    }
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
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
