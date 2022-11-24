//
//  ClientController.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-23.
//

import Foundation
import CoreData

/*
class ClientController {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private func addItem(addClient : String) {
        
        if (addClient == "") {
            return
        }
        
        let newClient = Client(context: viewContext)
        newClient.clientName = addClient
        
        do {
            try viewContext.save()
            //addClient = ""
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(clientList : Array<Any>, offsets: IndexSet) {
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
*/
