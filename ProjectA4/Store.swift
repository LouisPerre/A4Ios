//
//  Store.swift
//  ProjectA4
//
//  Created by Louis on 20/11/2023.
//

import Foundation

struct Store: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
}
