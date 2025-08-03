//
//  Untitled.swift
//  plann.er-18-journey
//
//  Created by Diogo on 09/03/2025.
//

import CoreData

class ActivityListViewModel {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchActivities() -> [Activity] {
           let request: NSFetchRequest<Activity> = Activity.fetchRequest()
           do {
               return try context.fetch(request)
           } catch {
               print("Fetch error: \(error)")
               return []
           }
       }
}
