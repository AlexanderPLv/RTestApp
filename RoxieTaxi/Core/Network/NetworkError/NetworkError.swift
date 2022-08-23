//
//  NetworkError.swift
//  RoxieTaxi
//
//  Created by Alexander Pelevinov on 26.07.2022.
//

import Foundation

enum NetworkError: String, Error {
    case invalidRequest = "invalid request."
    case badData = "Bad data."
    case parsingError = "Parsing error."
    case encodingFailed = "Parameter encoding failed."
    case parametersNil = "Parameters were nil."
    case missingURL = "Missing URL."
    case requestFailed = "Fail Request"
    case cantMakeRequest = "Fail to make request."
    case missedToken = "Token were nil."
}
extension NetworkError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "")}
}
