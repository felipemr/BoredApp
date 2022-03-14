//
//  MainViewModel.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/13/22.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {

    @Published var activities: [Activity] = []
    @Published var randomAcitivity: Activity?
    @Published var requestIsLoaded = false

    let persistenceController = PersistenceController.shared

    func addNewRandomActivity() {
        let urlString = NetworkManager.baseURL
        NetworkManager.shared.getData(for: urlString) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    do {
                        let activity = try JSONDecoder().decode(Activity.self, from: data)
                        self?.activities.append(activity)
                        self?.addActivity(activity)
                    } catch(let error) {
                        print(error.localizedDescription)
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }

    func getNewRandomActivity() {
        let urlString = NetworkManager.baseURL
        NetworkManager.shared.getData(for: urlString) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    do {
                        self?.randomAcitivity = try JSONDecoder().decode(Activity.self, from: data)
                        self?.requestIsLoaded = true
                    } catch(let error) {
                        print(error.localizedDescription)
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }

    func fetchActivities() {
        let savedEntities = persistenceController.savedEntities
        for savedEntity in savedEntities {
            let newActivity = Activity(from: savedEntity)
            var isNew = true
            for activity in activities {
                if activity.key == newActivity.key {
                    isNew = false
                }
            }
            if isNew {
                activities.append(newActivity)
            }
        }
    }

    func addActivity(_ newActivity: Activity) {
        persistenceController.addActivity(newActivity)
        fetchActivities()
    }

    func updateActivity(entity: ActivityEntity) {
        persistenceController.updateActivity(entity: entity)
        fetchActivities()
    }

    func deleteActivity(indexSet: IndexSet){
        persistenceController.deleteActivity(indexSet: indexSet)
        fetchActivities()
    }
}
