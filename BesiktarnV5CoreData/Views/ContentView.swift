//
//  ContentView.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Client.clientName, ascending: true)],
        animation: .default)
    
    private var clientList: FetchedResults<Client>

    @State var clientItems = [Client]()
    @State var addClient = ""
        
    var body: some View {
        NavigationView {
            
            VStack {
                HStack{
                    TextField("Lägg till objekt", text: $addClient)
                        .padding(.leading)
                        .keyboardType(.default)
                    
                    Button(action: addItem) {
                        Text("+")
                            .font(.title)
                    }
                    EditButton()
                        .padding(.trailing)
                }
                
                
                List {
                    ForEach(clientList) { client in
                        NavigationLink(destination: RoomView(currentClient: client)) {
                            Text(client.clientName!)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle(Text("Besiktningar"))
                .scrollContentBackground(.hidden)
                .listStyle(.inset)
            }
        }
    }

    
    

    private func addItem() {
        withAnimation {
            
            if (addClient == "") {
                return
            }
            
            let newClient = Client(context: viewContext)
            newClient.clientName = addClient

            do {
                try viewContext.save()
                addClient = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { clientList[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
