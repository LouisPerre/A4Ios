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
    
    @Binding var Course: Course
    @Binding var CoursesList: [Course]
    
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
                        .background(Course.colorToShow)
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
                trailing: NavigationLink(destination: ContentView(), label: {
                    Image(systemName: "pencil")
                })
            )
        }
    }
}

#Preview {
    SingleCourse(Course: .constant(Course(id: UUID(), name: "Spaghetti", dateToBuy: Date(), imageUrl: nil, price: 20.0, colorToShow: Color.brown, store: Store(id: UUID(), name: "Fnac"), urgency: .low)), CoursesList: .constant([
        Course(id: UUID(), name: "Spaghetti", dateToBuy: Date(), imageUrl: nil, price: 20.0, colorToShow: Color.brown, store: Store(id: UUID(), name: "Fnac"), urgency: .low),
        Course(id: UUID(), name: "Steak", dateToBuy: Date(), imageUrl: nil, price: 5.0, colorToShow: Color.red, store: Store(id: UUID(), name: "Carrefour"), urgency: .urgent),
        Course(id: UUID(), name: "Iphone 15 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal),
        Course(id: UUID(), name: "Iphone 14 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal)
        ]))
}
