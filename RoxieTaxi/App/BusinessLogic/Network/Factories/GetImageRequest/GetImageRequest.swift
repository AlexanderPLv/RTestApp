//
//  GetImageRequest.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

protocol GetImageRequestFactory {
    func get(
        with imageName: String,
        completion: @escaping (Result<[ImageData], Error>) -> Void
    )
}

final class GetImageRequest {
    let sessionManager: URLSession
    var serializer: DecodableSerializer<EndPoint.ModelType>
    let encoder: ParameterEncoder
    init(
        sessionManager: URLSession,
        serializer: DecodableSerializer<EndPoint.ModelType>,
        encoder: ParameterEncoder
    ) {
        self.sessionManager = sessionManager
        self.serializer = serializer
        self.encoder = encoder
    }
}

extension GetImageRequest: AbstractRequestFactory {
    typealias EndPoint = GetImageResource
    func request(
        withCompletion completion: @escaping (Result<[EndPoint.ModelType], Error>) -> Void
    ) {}
}

extension GetImageRequest: GetImageRequestFactory {
    func get(
        with imageName: String,
        completion: @escaping (Result<[ImageData], Error>) -> Void
    ) {
        let route = GetImageResource(imageName: imageName)
        request(route, withCompletion: completion)
    }
}
