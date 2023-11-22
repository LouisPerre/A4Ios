//
//  CourseCell.swift
//  ProjectA4
//
//  Created by Louis Perrenot on 22/11/2023.
//

import SwiftUI

struct CourseCell: View {
    @ObservedObject var Course: Course
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        HStack(alignment: .center) {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Course.colorToShow)
                .padding(4)
                .overlay(
                    Circle()
                        .stroke(Course.colorToShow, lineWidth: 2)
                )
            Text("\(Course.name)")
            Spacer()
            Text("\(dateFormatter.string(from: Course.dateToBuy))")
        }
    }
}

#Preview {
    CourseCell(Course: Course.previewCourse[0])
}
