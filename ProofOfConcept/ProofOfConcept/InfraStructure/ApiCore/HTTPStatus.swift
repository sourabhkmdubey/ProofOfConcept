//
//  HTTPStatus.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 23/11/21.
//

import Foundation

enum HTTPStatus : Int {
    case ok = 200
    case unauthorized = 401
    case badRequest = 500
    case noInternet = 1009
    case badUrl = 404
}
