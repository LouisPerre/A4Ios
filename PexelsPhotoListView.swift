// PexelsPhotoListView.swift

import SwiftUI

struct PexelsPhotoListView: View {
    var photos: [PexelsAPIResponse.Photo]
    @Binding var selectedImageUrl: String?

    let gridColumns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: 10) {
            ForEach(photos, id: \.id) { photo in
                Button(action: {
                    selectedImageUrl = photo.src.original
                    dismiss()
                }) {
                    AsyncImage(url: URL(string: photo.src.original)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 100)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .shadow(radius: 2)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.bottom, 10)  // Ajoutez un padding en bas de chaque image
            }
        }
        .padding(10)
    }
}
