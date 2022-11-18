//
//  RoomView.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-17.
//

import SwiftUI
import CoreData

struct RoomView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var currentClient : Client
    
    @State var roomName = ""
    
    @State var addRoom = ""
    
    @State var roomList = [Room]()
    
    var body: some View {
        VStack {
            
            TextField("Lägg till rum", text: $addRoom)
            
            List {
                ForEach(roomList) { room in
                    NavigationLink(destination: NoteView()) {
                        Text(room.roomName!)
                    }
                    
                    
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    
                    Button(action: {
                        saveRoom()
                    }){
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }.onAppear() {
            roomName = currentClient.clientName!
            
            loadRoom()
        }
    }
    
    
    
    func loadRoom() {
        if let roomSet = currentClient.roomrelationship {
            
            let rooms = roomSet as! Set <Room>
            
            let roomArray = Array(rooms)
            
            roomList = roomArray
        }
    }
    
    func saveRoom() {
        let newRoom = Room(context: viewContext)
        newRoom.roomName = addRoom
        
        currentClient.addToRoomrelationship(newRoom)
        
        do {
            try viewContext.save()
        } catch {
            //Kunde inte spara
        }
        loadRoom()
    }
    
    
    private func addItem() {
        withAnimation {
            let newRoom = Room(context: viewContext)
            newRoom.roomName = addRoom
            
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
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { roomList[$0] }.forEach(viewContext.delete)
            
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

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(currentClient: Client())
    }
}
