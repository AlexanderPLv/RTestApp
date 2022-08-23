//
//  EndPointType.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import Foundation

protocol EndPointType {
    associatedtype ModelType: Decodable
    var host: BaseURL { get }
    var path: Path { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters { get }
    var queryItems: [URLQueryItem] { get }
}

extension EndPointType {
    func url() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.baseURL
        components.path = path.path
        components.queryItems = queryItems
        guard let url = components.url else { return nil }
        return url
    }
    
}

enum BaseURL {
    case roxie
}

extension BaseURL {
    var baseURL: String {
        switch self {
        case .roxie:
            return "www.roxiemobile.ru"
        }
    }
}

enum Path {
    case orders
    case image
}

extension Path {
    var path: String {
        switch self {
        case .orders:
            return "/careers/test/orders.json"
        case .image:
            return "/careers/test/images"
        }
    }
}
