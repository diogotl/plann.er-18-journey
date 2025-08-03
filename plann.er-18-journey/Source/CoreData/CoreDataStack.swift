//
//  CoreDataStack.swift
//  plann.er-18-journey
//
//  Created by Diogo on 30/07/2025.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "Travel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
