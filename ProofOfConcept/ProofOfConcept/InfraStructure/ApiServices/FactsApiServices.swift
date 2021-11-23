//
//  FactsApiServices.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

protocol FactsApiServicesProtocol {
    var apiClient: ApiClientProtocol? {get set}
    func getFactsData( completion: @escaping (Facts?,Error?)->())
}

final class FactsApiServices: FactsApiServicesProtocol {
    var apiClient: ApiClientProtocol?
    
    //MARK:- Initializer
    init() {
        self.apiClient = ApiClient.init();
   }
    
    //Fetch The fact Data
    func getFactsData(completion: @escaping (Facts?,Error?)->()) {
        guard let apiClient = self.apiClient else {
            completion(nil, APIError.somthingWentWrong)
            return
        }
        guard let url = URL(string: ApiEndPoint.Facts.facts) else {
            completion(nil, APIError.resourceNotFound)
            return
        }
        let urlRequest = URLRequest(url: url)
        apiClient.hitAPI(with: urlRequest, responseType: Facts.self, completion: completion)
    }
    
}
