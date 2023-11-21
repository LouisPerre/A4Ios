//
//  Course.swift
//  ProjectA4
//
//  Created by Louis on 20/11/2023.
//

import Foundation
import SwiftUI

enum CourseUrgency: String, CaseIterable {
    case low = "Pas urgente"
    case normal = "Normal"
    case urgent = "Urgent"
}

struct Course: Identifiable {
    let id: UUID
    let name: String
    let dateToBuy: Date
    let imageUrl: String?
    let price: Float
    let colorToShow: Color
    let store: Store
    let urgency: CourseUrgency
}
