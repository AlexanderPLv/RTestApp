//
//  RequestFactory.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

final class RequestFactory {
    
    static let shared = RequestFactory()
    
    private let commonSession: URLSession
    
    private init() {
        self.commonSession = URLSession.shared
    }
}

extension RequestFactory {
    func makeGetOrdersRequest() -> GetOrdersRequestFactory {
        let serializer = DecodableSerializer<OrderInfo>()
        let encoder = RequestEncoder()
        let request = GetOrdersRequest(
            sessionManager: commonSession,
            serializer: serializer,
            encoder: encoder
        )
        return request
    }
    
    func makeGetImageRequest() -> GetImageRequestFactory {
        let serializer = ImageDataSerializer<ImageData>()
        let encoder = URLPathParameterEncoder()
        let request = GetImageRequest(
            sessionManager: commonSession,
            serializer: serializer,
            encoder: encoder
        )
        return request
    }
}
