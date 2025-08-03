//
//  HomeViewModel.swift
//  plann.er-18-journey
//
//  Created by Diogo on 30/07/2025.
//

 class HomeViewModel {
     
     init(
        
     ){
            self.context = CoreDataStack.shared.persistentContainer.viewContext
     }
     
     func saveActivity(name: String) {
         let activity = Activity(context: context)
         activity.name = name
         do {
             try context.save()
         } catch {
             print("Save error: \(error)")
         }
     }
}
