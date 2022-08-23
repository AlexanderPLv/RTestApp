//
//  GetOrdersRequest.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

protocol GetOrdersRequestFactory {
    func get(
        completion: @escaping (Result<[OrderInfo], Error>) -> Void
    )
}

final class GetOrdersRequest {
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

extension GetOrdersRequest: AbstractRequestFactory {
    typealias EndPoint = GetOrdersResource
    func request(
        withCompletion completion: @escaping (Result<[EndPoint.ModelType], Error>) -> Void
    ) {}
}

extension GetOrdersRequest: GetOrdersRequestFactory {
    func get(
        completion: @escaping (Result<[EndPoint.ModelType], Error>) -> Void
    ) {
        let route = GetOrdersResource()
        request(route, withCompletion: completion)
    }
}
