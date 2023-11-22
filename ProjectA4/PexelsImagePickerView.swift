//
//  PexelsImagePickerView.swift
//  ProjectA4
//
//  Created by Louis Perrenot on 22/11/2023.
//

import SwiftUI

struct PexelsImagePickerView: View {
    var onImageSelected: (String) -> Void
    @State private var selectedImageUrl = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text(selectedImageUrl)
                // Mettez ici la logique pour afficher et sélectionner une image depuis l'API Pexels
                // Utilisez onImageSelected(selectedImageUrl) pour renvoyer l'URL sélectionné
            }
            .navigationTitle("Sélectionner une image depuis Pexels")
            .navigationBarItems(trailing:
                Button("Fermer") {
                    // Ajoutez ici la logique pour fermer la feuille modale
                }
            )
        }
    }
}

