//
//  JoueursList.swift
//  LesB0ules
//
//  Created by lois guillet on 19/08/2021.
//

import SwiftUI

struct JoueursList: View {
    let joueurs: [Person]
    @State var showModal = false
    
    var body: some View {
        ZStack{
            List(joueurs){ _joueur in
                NavigationLink(destination: JoueurDetail(joueur: _joueur)){
                    JoueurRow(joueur: _joueur)
                }
            }
            .navigationBarHidden(false)
            .navigationBarItems(trailing: Button(action: {
                withAnimation {
                    self.showModal.toggle()
                }
                }) {
                    Image(systemName: "plus")
            })
            if showModal {
                Rectangle() // the semi-transparent overlay
                    .foregroundColor(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)

                GeometryReader { geometry in // the modal container
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        .frame(width: min(geometry.size.width - 100, 300), height: min(geometry.size.height - 100, 200))
                        .overlay(ModalContentViewJoueur(showModal: self.$showModal))
                }
                .transition(.move(edge: .bottom))

            }
        }
        
    }
}

struct ModalContentViewJoueur: View {
    @Binding var showModal: Bool
    @State var nom = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        VStack {
            Text("Ajouter un joueur")
            Form {
                TextField("Username", text: self.$nom)
            }
            HStack{
                Button(action: {
                    withAnimation {
                        self.showModal.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                        Text("Annuler")
                    }
                }
                Button(action: {
                    withAnimation {
                        //save into storage
                        do{
                            
                            //close modal
                            self.showModal.toggle()
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                        Text("Ajouter")
                    }
                }
            }
        }
    }
}


//struct JoueursList_Previews: PreviewProvider {
//    static var previews: some View {
//        JoueursList(joueurs: [
//            Joueur(prenom: "bob3"),
//            Joueur(prenom: "bob4")
//        ])
//    }
//}
