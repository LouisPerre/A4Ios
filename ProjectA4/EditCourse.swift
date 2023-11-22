//
//  EditCourse.swift
//  ProjectA4
//
//  Created by Louis on 21/11/2023.
//

import SwiftUI

let storeList = [
        Store(id: UUID(), name: "Fnac"),
        Store(id: UUID(), name: "Apple"),
        Store(id: UUID(), name: "Carrefour"),
        Store(id: UUID(), name: "Castorama"),
        Store(id: UUID(), name: "Metro")
    ]

struct EditCourse: View {
    @ObservedObject var Course: Course
    
    @State var imageString = ""
    @State var showEditCourse: Bool
    
    private var formattedPrice: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Nom de la course", text: $Course.name)
                        TextField("Prix de la course", value: $Course.price, formatter: formattedPrice).keyboardType(.numberPad)
                    }
    //                Section {
    //                    AsyncImage(url: URL(string: imageString)) {
    //                        image in image
    //                            .resizable()
    //                            .aspectRatio(contentMode: .fit)
    //                    } placeholder: {
    //                        Image("mike-petrucci-c9FQyqIECds-unsplash")
    //                            .resizable()
    //                            .aspectRatio(contentMode: .fill)
    //                    }
    //                    .frame(width: 300, height: 300)
    //                    .padding()
    //                    if Course.imageUrl != nil {
    //                        imageString = $Course.imageUrl!
    //                        TextField("Image de la course", text: $imageString)
    //                    } else {
    //                        TextField("Image de la course", text: $imageString)
    //                    }
    //
    //                    Button(action: {
    //                        imageString = Course.imageUrl
    //                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    //                    }, label: {
    //                        Text("Changer l'image")
    //                    })
    //                }
                    Section {
                        DatePicker("Date pour la course", selection: $Course.dateToBuy, displayedComponents: [.date])
                        ColorPicker("Couleur associée", selection: $Course.colorToShow, supportsOpacity: false)
                        Picker("Magasin", selection: $Course.store) {
                            ForEach(storeList) { store in
                                Text(store.name).tag(store)
                            }
                        }
                        Picker("Urgence", selection: $Course.urgency) {
                            ForEach(CourseUrgency.allCases, id: \.self) {
                                urgence in
                                Text(urgence.rawValue).tag(urgence)
                            }
                        }
                    }
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    dismiss()
                }) {
                    Text("Enregister")
                }
            )
        }
    }
}

#Preview {
    EditCourse(Course: Course.previewCourse[0], showEditCourse: true)
}
