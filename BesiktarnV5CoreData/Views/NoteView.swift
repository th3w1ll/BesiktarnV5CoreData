//
//  NoteView.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-17.
//

import SwiftUI
import CoreData

struct NoteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var currentRoom : Room
    
    @State var noteName = ""
    
    @State var addNote = ""
    
    @State var noteList = [Note]()
    
    var body: some View {
        
        VStack {
            
            TextField("Lägg till anteckningar", text: $addNote)
            
            List {
                ForEach(noteList) { note in
                    Text(note.roomNote!)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    
                    Button(action: {
                        saveNote()
                    }){
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Lägg till och välj rum")
        }.onAppear() {
            noteName = currentRoom.roomName!
            
            loadNote()
        }
    }
    
    func loadNote() {
        if let noteSet = currentRoom.noterelationship {
            
            let notes = noteSet as! Set <Note>
            
            let noteArray = Array(notes)
            
            noteList = noteArray
        }
    }
    
    func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.roomNote = addNote
        
        currentRoom.addToNoterelationship(newNote)
        
        do {
            try viewContext.save()
        } catch {
            //Kunde inte spara
        }
        loadNote()
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { noteList[$0] }.forEach(viewContext.delete)
            
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

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(currentRoom: Room())
    }
}
