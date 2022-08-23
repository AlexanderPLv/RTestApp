//
//  RequestEncoder.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

struct RequestEncoder: ParameterEncoder {
    public func encode(
        urlRequest: inout URLRequest,
        with parameters: Parameters
    ) throws {
        urlRequest.setValue(
            RequestContentType.appJSON,
            forHTTPHeaderField: HTTPHeaderFields.contentType
        )
    }
}
