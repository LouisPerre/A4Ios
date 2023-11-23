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
                .scaleEffect(isPulsating ? 1.2 : 1.0)
            Text("\(Course.name)")
            Spacer()
            Text("\(dateFormatter.string(from: Course.dateToBuy))")
        }
        .onAppear() {
//            isPulsating.toggle()
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isPulsating.toggle()
            }
        }
    }
    @State private var isPulsating = false
}

#Preview {
    CourseCell(Course: Course.previewCourse[0])
}
