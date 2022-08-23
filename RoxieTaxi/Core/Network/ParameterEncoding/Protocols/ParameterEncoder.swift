//
//  ParameterEncoder.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    func encode(
        urlRequest: inout URLRequest,
        with parameters: Parameters
    ) throws
}
