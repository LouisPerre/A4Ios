//
//  AddCourse.swift
//  ProjectA4
//
//  Created by Louis on 20/11/2023.
//

import SwiftUI

let storesList = [
        Store(id: UUID(), name: "Fnac"),
        Store(id: UUID(), name: "Apple"),
        Store(id: UUID(), name: "Carrefour"),
        Store(id: UUID(), name: "Castorama"),
        Store(id: UUID(), name: "Metro")
    ]

struct AddCourse: View {
    
    @Binding var CoursesList: [Course]
    
    @State var productName = ""
    @State var imageString = ""
    @State var imageUrl = ""
    @State var dateToBuy = Date()
    @State var price: Float = 0
    @State var color: Color = Color.white
    @State private var selectedStore: Store = storesList.first!
    @State var selectedUrgency: CourseUrgency = CourseUrgency.normal
    
    
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
//        Text("Hello World !")
        VStack {
            Form {
                Section {
                    TextField("Nom de la course", text: $productName)
                    DatePicker("Quand l'acheter", selection: $dateToBuy, displayedComponents: [.date])
                    TextField("Image", text: $imageString)
                    TextField("0.00", value: $price, formatter: formattedPrice).keyboardType(.numberPad)
                    ColorPicker("Couleur associée", selection: $color, supportsOpacity: false)
                    Picker("Magasin", selection: $selectedStore) {
                        ForEach(storesList) { store in
                            Text(store.name).tag(store)
                        }
                    }
                    Picker("Urgence", selection: $selectedUrgency) {
                        ForEach(CourseUrgency.allCases, id: \.self) { urgence in
                            Text(urgence.rawValue).tag(urgence)
                            
                        }
                    }
                    .pickerStyle(.segmented)
//                    if let selectedStore = selectedStore {
//                        Text("Magasin : \(selectedStore.name)")
//                    } else {
//                        Text("Pas de magasin")
//                    }
                } header: {
                    Text("Créer une course")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.black)
                }
                
                Section {
                    AsyncImage(url: URL(string: imageUrl)) {
                        image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Image("mike-petrucci-c9FQyqIECds-unsplash")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 300, height: 300)
                    .padding()
                    
                    Button(action: {
                        imageUrl = imageString
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("Charger l'image")
                    })
                }
                
                Button(action: {
                    print("lala")
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    CoursesList.append(Course(id: UUID(), name: productName, dateToBuy: dateToBuy, imageUrl: imageUrl, price: price, colorToShow: color, store: selectedStore, urgency: selectedUrgency))
                    dismiss()
                }, label: {
                    Text("Ajouter la course")
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                })
            }
            .navigationBarTitle("Settings")
        }
    }
}

#Preview {
    AddCourse(CoursesList: .constant([
        Course(id: UUID(), name: "Spaghetti", dateToBuy: Date(), imageUrl: nil, price: 20.0, colorToShow: Color.brown, store: Store(id: UUID(), name: "Fnac"), urgency: .low),
        Course(id: UUID(), name: "Steak", dateToBuy: Date(), imageUrl: nil, price: 5.0, colorToShow: Color.red, store: Store(id: UUID(), name: "Carrefour"), urgency: .urgent),
        Course(id: UUID(), name: "Iphone 15 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal),
        Course(id: UUID(), name: "Iphone 14 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal)
        ]))
}
