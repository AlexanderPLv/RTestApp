//
//  GetOrdersResource.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 27.07.2022.
//

import Foundation

struct GetOrdersResource: EndPointType {
    typealias ModelType = OrderInfo
    var host: BaseURL = .roxie
    var path: Path = .orders
    var httpMethod: HTTPMethod = .get
    var parameters: Parameters = [:]
    var queryItems: [URLQueryItem] = []
}
