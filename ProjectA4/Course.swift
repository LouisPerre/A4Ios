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

class CoursesCollection: ObservableObject {
    @Published var courses: [Course]
    
    init(courses: [Course]) {
        self.courses = courses
    }
}

class Course: Identifiable, ObservableObject {
    let id: UUID = UUID()
    @Published var name: String
    @Published var dateToBuy: Date
    @Published var imageUrl: String?
    @Published var price: Float
    @Published var colorToShow: Color
    @Published var store: Store
    @Published var urgency: CourseUrgency
    
    init(name: String, dateToBuy: Date, imageUrl: String? = nil, price: Float, colorToShow: Color, store: Store, urgency: CourseUrgency) {
        self.name = name
        self.dateToBuy = dateToBuy
        self.imageUrl = imageUrl
        self.price = price
        self.colorToShow = colorToShow
        self.store = store
        self.urgency = urgency
    }
}

extension Course {
    static let previewCourse: [Course] = [
        Course(name: "Spaghetti", dateToBuy: Date(), imageUrl: nil, price: 20.0, colorToShow: Color.brown, store: Store(id: UUID(), name: "Fnac"), urgency: .low),
        Course(name: "Steak", dateToBuy: Date(), imageUrl: nil, price: 5.0, colorToShow: Color.red, store: Store(id: UUID(), name: "Carrefour"), urgency: .urgent),
        Course(name: "Iphone 15 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal),
        Course(name: "Iphone 14 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal)
    ]
}
