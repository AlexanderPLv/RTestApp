//
//  Serializer.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import Foundation

class DecodableSerializer<ModelType: Decodable> {
    func decode(_ data: Data) throws -> [ModelType] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let value = try decoder.decode([ModelType].self, from: data)
        return value
    }
}

protocol Datable: Decodable {
    var data: Data? { get }
    static func build(with data: Data) -> Self
}

final class ImageDataSerializer<ModelType: Datable>: DecodableSerializer<ModelType> {
    override func decode(_ data: Data) throws -> [ModelType] {
        let value = ModelType.build(with: data)
        let array = [value]
        return array
    }
}
