//
//  Activity.swift
//  Bored App
//
//  Created by Felipe Marques Ramos on 3/11/22.
//

import Foundation

struct Activity: Codable, Hashable {
    let activity: String
    let type: String
    let participants: Int?
    let price: Double?
    let link: String?
    let key: String
    let accessibility: Double?

    init(from entity: ActivityEntity){
        self.activity = entity.activity ?? "Error"
        self.type = entity.type ?? "No Type"
        self.key = entity.key ?? "\(UUID())"

        self.participants = 0
        self.price = 0.0
        self.link = ""
        self.accessibility = 0.0
    }
}

struct ErrorActivity: Codable {
    let error: String
}
