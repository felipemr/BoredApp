//
//  MainViewModel.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/13/22.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var activities: [Activity] = []

    func addNewRandomActivity() {
        let urlString = NetworkManager.baseURL
        NetworkManager.shared.getData(for: urlString) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    do {
                        let activity = try JSONDecoder().decode(Activity.self, from: data)
                        self?.activities.append(activity)
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
}