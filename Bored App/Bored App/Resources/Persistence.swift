//
//  Persistence.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for x in 0..<10 {
            let newItem = ActivityEntity(context: viewContext)
            newItem.activity = "Activity \(x)"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    var savedEntities: [ActivityEntity] = []

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Bored_App")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("it works!")
            }
        })
    }

    func addActivity(_ newActivity: Activity) {
        let newEntity = ActivityEntity(context: container.viewContext)
        newEntity.activity = newActivity.activity
        newEntity.type = newActivity.type
        newEntity.key = newActivity.key
        saveData()
    }

    func updateActivity(entity: ActivityEntity) {
        let currentName = entity.activity ?? ""
        let newName = currentName + "!"
        entity.activity = newName
        saveData()
    }

    func deleteActivity(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }

    private func saveData() {
        do {
            try container.viewContext.save()
            fetchActivities()
        } catch(let erro) {
            fatalError("FATAL ERROR \(erro)")
        }
    }

    private func fetchActivities(){
        let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch(let erro) {
            print("Error Fetching: \(erro)")
        }
    }
}
