//
//  Previewing.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-21.
//

import CoreData
import SwiftUI

struct Previewing<Content: View, Model>: View {
    var content: Content
    var persistance: PersistenceController
    
    init (_ keyPath: KeyPath<PreviewingData, (NSManagedObjectContext) -> Model>, @ViewBuilder content: (Model) -> Content) {
        
        self.persistance = PersistenceController(inMemory: true)
        let data = PreviewingData()
        let closure = data[keyPath: keyPath]
        let models = closure(persistance.container.viewContext)
        
        self.content = content(models)
    }
    
    init(contextWith KeyPath: KeyPath<PreviewingData, (NSManagedObjectContext) -> Model>, @ViewBuilder content: () -> Content) {
        
        self.persistance = PersistenceController(inMemory: true)
        let data = PreviewingData()
        let closure = data[keyPath: keyPath]
        
        _ = closure(persistance.container.viewContext)
        
        self.content = content()
        
    }
    
    
    var body: some View {
        content
            .environment(\.managedObjectContext, persistance.container.viewContext)
    }
}


struct PreviewingData {
    var items: (NSManagedObjectContext) -> [Item] {{ context in
        var createdItems = [Item]()
        for _ in 0..<15 {
            let newItem = Item(context: context)
            newItem.timestamp = Date()
            createdItems.append(newItem)
        }
        return createdItems
    }}
}


