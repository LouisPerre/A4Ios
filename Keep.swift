////
////  ContentView.swift
////  ProjectA4
////
////  Created by Louis Perrenot on 20/11/2023.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @State var buttonBackgroundColor: Color = .green
//    @State var productName = ""
//    @State var imageString = ""
//    @State var imageUrl = ""
//    @State var date = Date()
//    @State var price: Float = 0
//    @State var color: Color = Color.white
//    
//    private let numberFormatter: NumberFormatter
//    
//    init() {
//          numberFormatter = NumberFormatter()
//          numberFormatter.numberStyle = .currency
//          numberFormatter.maximumFractionDigits = 2
//        }
//    
//    // Tout ce qui est UI
//    var body: some View {
//        VStack {
//            Form {
//                Section {
//                    TextField("Name", text: $productName)
//                    DatePicker("Date d'achat", selection: $date, displayedComponents: [.date])
//                    TextField("Image", text: $imageString)
//                    TextField("0,00", value: $price, formatter: numberFormatter)
//                        .keyboardType(.numberPad)
//                    ColorPicker("Couleur d'affichage", selection: $color, supportsOpacity: false)
//                } header: {
//                    Text("Créer une course")
//                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .foregroundStyle(Color.black)
//                }
//                
//                Section {
//                    AsyncImage(url: URL(string: imageUrl)) {
//                        image in image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                    } placeholder: {
//                        Rectangle()
//                            .foregroundColor(.gray)
//                    }
//                    .frame(width: 300, height: 300)
//                    .padding()
//                    Button(action: {
//                        imageUrl = imageString
//                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                    }, label: {
//                        Text("Charger l'image")
//                    })
//                }
//                
//                Button(action: {
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                }, label: {
//                    Text("Ajouter")
//                        .foregroundStyle(Color.white)
//                        .padding()
//                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                })
//            }
//            .navigationBarTitle("Settings")
//            
////            Image("eb3a7ee4fb78ce25efdb622df6202d78")
////                .resizable()
////                .aspectRatio(contentMode: .fill)
////                .frame(width: 300, height: 300)
////                .clipped()
////                .clipShape(Rectangle())
////                .frame(width: UIScreen.main.bounds.width)
//                
////            Image(systemName: "bolt.horizontal.fill")
////                .font(.system(size: 50))
////                .foregroundStyle(Color.purple)
////            HStack {
////                Text("Hello")
////                    .font(.system(size: 36))
////                    .foregroundStyle(Color.blue)
////                Text("Hello")
////                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
////            }
////            .padding()
////            .background(Color.red)
////            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $name)
////            Button(action: {
////                if buttonBackgroundColor == .red {
////                    buttonBackgroundColor = .green
////                } else {
////                    buttonBackgroundColor = .red
////                }
////            }, label: {
////                Text("\(name)")
////                    .font(.title)
////                    .foregroundStyle(Color.red)
////                    .padding()
////                    .background(buttonBackgroundColor)
////            })
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
