//
//  LesB0ulesApp.swift
//  LesB0ules
//
//  Created by lois guillet on 18/08/2021.
//

import SwiftUI
import CoreData

@main
struct LesB0ulesApp: App {
    
    let persistenceController = PersistenceController.shared
        
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("Scene is in background")
                persistenceController.save()
            case .inactive:
                print("Scene is inactive")
            case .active:
                //ViewModelPhone().sync()
                print("Scene is active")
            @unknown default:
                print("Apple must have changed something")
            }
        }
    }
}
