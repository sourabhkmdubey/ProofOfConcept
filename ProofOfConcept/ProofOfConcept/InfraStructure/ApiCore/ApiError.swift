//
//  ApiError.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

enum APIError: Error {
    case unAuthorizedRequest
    case noconverionOfData
    case somthingWentWrong
    case noDataFromServer
    case notDataIsParsed
    case resourceNotFound
}
extension APIError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .somthingWentWrong:
            return "Something has went wrong."
        case .unAuthorizedRequest:
            return "You are not authorized to access."
        case .noconverionOfData:
            return "Data is not in correct format."
        case .notDataIsParsed:
            return "Not able to parse the data"
        case .noDataFromServer:
             return "No data is returned from server"
        case .resourceNotFound:
            return "404 Not Found"
        }
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
