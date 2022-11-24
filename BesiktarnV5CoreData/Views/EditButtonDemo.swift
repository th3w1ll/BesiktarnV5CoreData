//
//  EditButtonDemo.swift
//  BesiktarnV5CoreData
//
//  Created by Patrik Korab on 2022-11-23.
//

import SwiftUI

struct EditButtonDemo: View {
    
    @State var items = [
        "Björn", "Gris", "Hjort", "Apa", "Sumo", "Fisk", "Alpaca", "Annat"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                //Enable Delete
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .listStyle(.inset)
            .navigationTitle("Total \(items.count) items")
            .navigationBarItems(leading: Button(action: {
                //Code goes here
            }, label: {Text("Add")
            }), trailing: EditButton()) //Auto Edit
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            items.remove(at: first)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        let reversedSource = source.sorted()
        for index in reversedSource.reversed() {
            items.insert(items.remove(at: index), at: destination)
        }
    }
    
}

struct EditButtonDemo_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonDemo()
    }
}
