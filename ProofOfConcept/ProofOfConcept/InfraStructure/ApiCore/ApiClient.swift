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
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if data != nil {
                do {
                    guard let responseData = data,
                          let jsonString = String(data: responseData, encoding: .iso2022JP),
                          let JSONdata = jsonString.data(using: .utf8) else {
                        return completion(nil, APIError.somthingWentWrong)
                    }
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: JSONdata)
                    completion(object, nil)
                } catch {
                    completion(nil, APIError.somthingWentWrong)
                }
            } else if error != nil {
                completion(nil, APIError.somthingWentWrong)
            }
        }.resume()
    }
}
