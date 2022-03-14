//
//  SearchViewModel.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/13/22.
//

import Foundation

class SearchViewModel: ObservableObject {

    @Published var filteredActivity: Activity?
//    @Published var isLoading = false

    func getNewFilteredActivity(with filters: [String:String]) {
        let urlString = NetworkManager.baseURL + buildURL(from: filters)

//        isLoading = true
        NetworkManager.shared.getData(for: urlString) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    do {
                        self?.filteredActivity = try JSONDecoder().decode(Activity.self, from: data)
                    } catch(let error) {
                        if let err = try? JSONDecoder().decode(ErrorActivity.self, from: data){
                            self?.filteredActivity = Activity(activity: err.error, type: "Error", participants: 0, price: 0.0, link: "", key: "00000", accessibility: 1)
                        }
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
//                self?.isLoading = false
            }
        }
    }

    private func buildURL(from attributes: [String:String]) -> String {
        guard !attributes.isEmpty else { return "" }

        var url = ""

        attributes.forEach { url += $0 + "=" + $1 + "&"}

        let _ = url.removeLast()

        return url
    }
}
