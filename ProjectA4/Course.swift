//
//  Course.swift
//  ProjectA4
//
//  Created by Louis on 20/11/2023.
//

import Foundation
import SwiftUI

enum CourseUrgency: String, CaseIterable, Codable {
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

class Course: Identifiable, ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name, dateToBuy, imageUrl, price, colorToShow, store, urgency
    }
    
    let id: UUID = UUID()
    @Published var name: String
    @Published var dateToBuy: Date
    @Published var imageUrl: String?
    @Published var price: Float
    @Published var colorToShow: Color = Color.black
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(dateToBuy, forKey: .dateToBuy)

        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(price, forKey: .price)

        try container.encode(store, forKey: .store)
        try container.encode(urgency, forKey: .urgency)
        
        let convertedColor = UIColor(colorToShow)
        let colorData = try NSKeyedArchiver.archivedData(withRootObject: convertedColor, requiringSecureCoding: false)
        try container.encode(colorData, forKey: .colorToShow)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        dateToBuy = try container.decode(Date.self, forKey: .dateToBuy)

        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        price = try container.decode(Float.self, forKey: .price)

        store = try container.decode(Store.self, forKey: .store)
        urgency = try container.decode(CourseUrgency.self, forKey: .urgency)
        
        if let colorData = try container.decodeIfPresent(Data.self, forKey: .colorToShow) {
            if let uiColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
                self.colorToShow = Color(uiColor)
            }
        }
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
