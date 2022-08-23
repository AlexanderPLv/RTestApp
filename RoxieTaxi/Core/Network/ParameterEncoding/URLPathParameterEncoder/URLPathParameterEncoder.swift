//
//  URLPathParameterEncoder.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

public struct URLPathParameterEncoder: ParameterEncoder {
    public func encode(
        urlRequest: inout URLRequest,
        with parameters: Parameters
    ) throws {
        guard var url = urlRequest.url
        else { throw NetworkError.missingURL }
        urlRequest.setValue(
            RequestContentType.imageJPG,
            forHTTPHeaderField: HTTPHeaderFields.contentType
        )
        guard !parameters.isEmpty else { return }
        for (_ ,value) in parameters {
            let pathComponent = String("\(value)")
            url.appendPathComponent(pathComponent)
        }
        urlRequest.url = url
    }
}
