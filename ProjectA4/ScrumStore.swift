//
//  ScrumStore.swift
//  ProjectA4
//
//  Created by Louis on 22/11/2023.
//

import Foundation
import SwiftUI

@MainActor
class ScrumStore: ObservableObject {
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    
    static func load() async throws->[Course] {
        let task = Task<[Course], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let courses = try JSONDecoder().decode([Course].self, from: data)
            return courses
        }
        let scrums = try await task.value
        return scrums
    }
    
    static func save(scrums: [Course]) async throws {
        print(scrums)
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

