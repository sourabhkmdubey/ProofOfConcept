//
//  ApiClient.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

final class ApiClient: ApiClientProtocol {
    
    func hitAPI<T:Decodable>(with urlRequest: URLRequest,
                             responseType: T.Type,
                             completion: @escaping (T?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let urlResponse = response as? HTTPURLResponse else {
                return completion(nil, error)
            }
            let status = urlResponse.statusCode
            self.handleResponse(status: status, data: data, error: error, responseType: responseType, completion: completion)
            
            
        }.resume()
    }
    
    
    func handleResponse<T:Decodable>(status: Int,
                        data: Data?,
                        error: Error?,
                        responseType: T.Type,
                        completion: @escaping (T?, Error?) -> Void) {
        switch status {
        case HTTPStatus.ok.rawValue:
            if data != nil {
                do {
                    guard let responseData = data,
                          let jsonString = String(data: responseData, encoding: .iso2022JP),
                          let JSONdata = jsonString.data(using: .utf8) else {
                        return completion(nil, APIError.noconverionOfData)
                    }
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: JSONdata)
                    completion(object, nil)
                } catch {
                    completion(nil, APIError.notDataIsParsed)
                }
            }else {
                completion(nil, APIError.noDataFromServer)
            }
        case HTTPStatus.badRequest.rawValue:
            completion(nil, APIError.somthingWentWrong)
            
        case HTTPStatus.unauthorized.rawValue:
            completion(nil, APIError.unAuthorizedRequest)
            
        case HTTPStatus.badUrl.rawValue:
            completion(nil, APIError.resourceNotFound)
            
        default:
            completion(nil, error)
        }
    }
}
