//
//  SingleCourse.swift
//  ProjectA4
//
//  Created by Louis Perrenot on 21/11/2023.
//

import SwiftUI

struct SingleCourse: View {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    private var formattedPrice: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    @ObservedObject var Course: Course
    @State private var showEditCourse = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack() {
                if Course.imageUrl != nil {
                    AsyncImage(url: URL(string: Course.imageUrl!)) {
                        image in image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                            .clipped()
                            .cornerRadius(10)
                    } placeholder: {
                        Image("mike-petrucci-c9FQyqIECds-unsplash")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                            .clipped()
                            .cornerRadius(10)
                    }
                } else {
                    Image("mike-petrucci-c9FQyqIECds-unsplash")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Date de l'achat : \(dateFormatter.string(from: Course.dateToBuy))")
                        .font(.subheadline)
                        .opacity(0.5)
                    Spacer()
                }
                HStack {
                    Text("Prix : ")
                    Spacer()
                    Text("\(Course.price.formatted()) €")
                        .padding(.horizontal)
                        .background(.regularMaterial)
                        .cornerRadius(5)
                }
                HStack {
                    Text("Couleur associée : ")
                    Rectangle()
                        .frame(height: 20)
                        .foregroundStyle(Course.colorToShow)
                        .cornerRadius(5)
                }
                HStack {
                    Text("Boutique : ")
                    Spacer()
                    Text("\(Course.store.name)")
                        .padding(.horizontal)
                        .background(.regularMaterial)
                        .cornerRadius(5)
                }
                HStack {
                    Spacer()
                    Text(Course.urgency.rawValue)
                    Spacer()
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(5)
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(Course.name)
            .navigationBarItems(
                trailing: Button(action: {
                    showEditCourse.toggle()
                }) {
                    Image(systemName: "pencil")
                }
                    .sheet(isPresented: $showEditCourse) {
                        EditCourse(Course: Course, showEditCourse: showEditCourse)
                    }
            )
        }
    }
}

#Preview {
    SingleCourse(Course: Course.previewCourse[0])
}
