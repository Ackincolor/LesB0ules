//
//  ContentView.swift
//  LesB0ules WatchKit Extension
//
//  Created by lois guillet on 18/08/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModelWatch()
    
    var body: some View {
        VStack{
            NavigationView{
                PartieList(parties: self.model.parties)
            }
            .navigationTitle("Parties")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
