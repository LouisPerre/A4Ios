//
//  PexelsAPIResponse.swift
//  ProjectA4
//
//  Created by Louis Perrenot on 22/11/2023.
//

import Foundation

struct PexelsAPIResponse: Decodable {
    struct Photo: Decodable {
        struct Src: Decodable {
            let original: String
        }

        let id: Int
        let src: Src
    }

    let photos: [Photo]
}
