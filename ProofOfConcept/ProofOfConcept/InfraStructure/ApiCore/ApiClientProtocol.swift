//
//  ApiClientProtocol.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

protocol ApiClientProtocol {
    func hitAPI<T:Decodable>(with urlRequest: URLRequest, responseType: T.Type, completion: @escaping (T?,Error?)->())
    func handleResponse<T:Decodable>(status: Int,
                        data: Data?,
                        error: Error?,
                        responseType: T.Type,
                        completion: @escaping (T?, Error?) -> Void)
}










