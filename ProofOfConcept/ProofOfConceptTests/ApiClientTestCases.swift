//
//  ApiClientTestCases.swift
//  ProofOfConceptTests
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation


import XCTest
@testable import ProofOfConcept

class ApiClientTestCases: XCTestCase {
    var apiClient: ApiClientProtocol?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiClient = ApiClient()
    }

    override func tearDown()  {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiClient = nil
    }

    func testApiClientWithCorrectURL() {
        
        let expectation = self.expectation(description: "testApiClientWithCorrectURL")
        
        let urlRequest = URLRequest(url: URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!)
        apiClient?.hitAPI(with: urlRequest, responseType: Facts.self, completion: { response, error in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testApiClientWithInCorrect() {
        
        let expectation = self.expectation(description: "testApiClientWithInCorrect")
        
        let urlRequest = URLRequest(url: URL(string: "https://dl.drop/2iodh4vg0eboxusercontent.com/sortkl/facts.jso")!)
        apiClient?.hitAPI(with: urlRequest, responseType: Facts.self, completion: { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
