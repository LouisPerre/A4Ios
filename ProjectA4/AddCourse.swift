//
//  AddCourse.swift
//  ProjectA4
//
//  Created by Louis on 20/11/2023.
//

import SwiftUI
import SwiftyTranslate

let storesList = [
    Store(id: UUID(), name: "Fnac"),
    Store(id: UUID(), name: "Apple"),
    Store(id: UUID(), name: "Carrefour"),
    Store(id: UUID(), name: "Castorama"),
    Store(id: UUID(), name: "Metro")
]

struct AddCourse: View {
    
    @ObservedObject var coursesCollection: CoursesCollection
    
    @State var productName = ""
    @State var imageString = ""
    @State var imageUrl = ""
    @State var dateToBuy = Date()
    @State var price: Float = 0
    @State var color: Color = Color.white
    @State private var selectedStore: Store = storesList.first!
    @State var selectedUrgency: CourseUrgency = CourseUrgency.normal
    @State private var isShowingPhotoPicker = false
    @State private var pexelsPhotos: [PexelsAPIResponse.Photo] = []
    @State private var selectedImageUrl: String?
    @State var translatedValue: String?
    
    
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
                } header: {
                    Text("Créer une course")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.black)
                }
                
                //                Section {
                //                    AsyncImage(url: URL(string: imageUrl)) {
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
                //
                //                    Button(action: {
                //                        imageUrl = imageString
                //                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                //                    }, label: {
                //                        Text("Charger l'image")
                //                    })
                //                }
                
                Section {
                    Button(action: {
                        fetchPexelsPhotos()
                        isShowingPhotoPicker.toggle()
                    }) {
                        Text("Choisir une photo depuis Pexels")
                    }
                    .sheet(isPresented: $isShowingPhotoPicker) {
                        PexelsPhotoListView(photos: pexelsPhotos, selectedImageUrl: $selectedImageUrl)
                    }
                    
                    if let imageUrl = selectedImageUrl {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                            
                        } placeholder: {
                            Image("placeholder_image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(width: 300, height: 300)
                        .padding()
                    }
                }
                
                Button(action: {
                    coursesCollection.courses.append(Course(name: productName, dateToBuy: dateToBuy, imageUrl: selectedImageUrl ?? "", price: price, colorToShow: color, store: selectedStore, urgency: selectedUrgency))
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
    
    private func fetchPexelsPhotos() {
        let apiKey = "QprF859P9BhSHL20k4yexJadcC96in9vAcSqvtFQVITdjZ0tuaAlbwyn"
        var query = imageString != "" ? imageString : "course"
        let perPage = 5 // Change the number of photos you want to fetch
        SwiftyTranslate.translate(text: query, from: "fr", to: "en") { result in
            switch result {
                case .success(let translation):
                    print("Translated: \(translation.translated)")
                    translatedValue = translation.translated
                    guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(translatedValue!)&per_page=\(perPage)") else { return }
                    
                    var request = URLRequest(url: url)
                    request.addValue("\(apiKey)", forHTTPHeaderField: "Authorization")
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print("Error fetching Pexels photos: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }
                        
                        do {
                            let result = try JSONDecoder().decode(PexelsAPIResponse.self, from: data)
                            print(result)
                            DispatchQueue.main.async {
                                pexelsPhotos = result.photos
                            }
                        } catch {
                            print("Error decoding Pexels photos JSON: \(error)")
                        }
                    }.resume()
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
}

#Preview {
    AddCourse(coursesCollection: CoursesCollection(courses:  Course.previewCourse))
}
