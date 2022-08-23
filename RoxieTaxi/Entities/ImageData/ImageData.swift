//
//  ImageData.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

struct ImageData: Datable {
    var data: Data?
    static func build(with data: Data) -> ImageData {
        ImageData(data: data)
    }
}
