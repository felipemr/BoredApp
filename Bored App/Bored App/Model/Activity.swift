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
}

struct ErrorActivity: Codable {
    let error: String
}
