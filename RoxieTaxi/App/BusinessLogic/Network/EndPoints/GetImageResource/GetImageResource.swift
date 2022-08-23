//
//  GetImageResource.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

struct GetImageResource: EndPointType {
    typealias ModelType = ImageData
    var host: BaseURL = .roxie
    var path: Path = .image
    var httpMethod: HTTPMethod = .get
    var imageName: String
    var parameters: Parameters {
    [
        "imageName": imageName
    ]
    }
    var queryItems: [URLQueryItem] = []
}
