//
//  FactsModel.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

// MARK: - Facts
struct Facts: Decodable {
    let title: String?
    var factDetails: [FactDetails]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case factDetails = "rows"
    }
    
    mutating func updateFactDetais(_ factDetails: [FactDetails]) {
        self.factDetails = factDetails
    }
}

// MARK: - FactsDetails
struct FactDetails: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}


