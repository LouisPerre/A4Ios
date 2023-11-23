//
//  ProjectA4App.swift
//  ProjectA4
//
//  Created by Louis Perrenot on 20/11/2023.
//

import SwiftUI

@main
struct ProjectA4App: App {
    @StateObject private var storeCollection: CoursesCollection = CoursesCollection(courses: [])
    var body: some Scene {
        WindowGroup {
            ContentView(myCoursesCollection: storeCollection) {
                Task {
                    do {
                        try await ScrumStore.save(scrums: storeCollection.courses)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    storeCollection.courses = try await ScrumStore.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
