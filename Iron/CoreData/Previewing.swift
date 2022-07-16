//
//  Previewing.swift
//  Iron
//
//  Created by Nick Schwab on 7/15/22.
//
import CoreData
import SwiftUI


struct Previewing<Content: View, Model>: View {
    
    var content: Content
    var persistence: PersistenceController
    
    ///Initializer that proides the instance of model
    init(_ keyPath: KeyPath<PreviewingData, (NSManagedObjectContext) -> Model>, @ViewBuilder content: (Model) -> Content) {
        self.persistence = PersistenceController(inMemory: true)
        let data = PreviewingData()
        let closure = data[keyPath: keyPath]
        let models = closure(persistence.container.viewContext)
        
        self.content = content(models)
    }
    
    init(contextWith keyPath: KeyPath<PreviewingData, (NSManagedObjectContext) -> Model>, @ViewBuilder content: () -> Content) {
        
        self.persistence = PersistenceController(inMemory: true)
        let data = PreviewingData()
        let closure = data[keyPath: keyPath]
        
        _ = closure(persistence.container.viewContext)
        self.content = content()
    }
    var body: some View {
        content
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
