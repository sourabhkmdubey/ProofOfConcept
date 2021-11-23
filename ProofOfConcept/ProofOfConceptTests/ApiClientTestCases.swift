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
            
            if error != nil {
                XCTAssertTrue(error?.code == -1009, "No internet connection")
            } else {
                XCTAssertNotNil(response)
                XCTAssertNil(error)
            }
            
            expectation.fulfill()
        })
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testApiClientWithInCorrect() {
        
        let expectation = self.expectation(description: "testApiClientWithInCorrect")
        
        let urlRequest = URLRequest(url: URL(string: "https://dl.drop/2iodh4vg0eboxusercontent.com/sortkl/facts.jso")!)
        apiClient?.hitAPI(with: urlRequest, responseType: Facts.self, completion: { response, error in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testApiClientWithNoData() {
        let expectation = self.expectation(description: "testApiClientWithNoData")
        apiClient?.handleResponse(status: 200, data: nil, error: nil, responseType: Facts.self, completion: { facts, error in
            XCTAssertTrue(error?.localizedDescription == APIError.noDataFromServer.localizedDescription)
            XCTAssertNil(facts)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testApiClientWithWrongData() {
        let expectation = self.expectation(description: "testApiClientWithWrongData")
        apiClient?.handleResponse(status: HTTPStatus.ok.rawValue, data: Data(), error: nil, responseType: Facts.self, completion: { facts, error in
            XCTAssertTrue(error?.localizedDescription == APIError.notDataIsParsed.localizedDescription)
            XCTAssertNil(facts)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testApiClientWithBadRequest() {
        let expectation = self.expectation(description: "testApiClientWithBadRequest")
        apiClient?.handleResponse(status: HTTPStatus.badRequest.rawValue, data: Data(), error: nil, responseType: Facts.self, completion: { facts, error in
            XCTAssertTrue(error?.localizedDescription == APIError.somthingWentWrong.localizedDescription)
            XCTAssertNil(facts)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testApiClientWithUnAuthorizedRequest() {
        let expectation = self.expectation(description: "testApiClientWithUnAuthorizedRequest")
        apiClient?.handleResponse(status: HTTPStatus.unauthorized.rawValue, data: Data(), error: nil, responseType: Facts.self, completion: { facts, error in
            XCTAssertTrue(error?.localizedDescription == APIError.unAuthorizedRequest.localizedDescription)
            XCTAssertNil(facts)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testApiClientWithBadURL() {
        let expectation = self.expectation(description: "testApiClientWithBadURL")
        apiClient?.handleResponse(status: HTTPStatus.badUrl.rawValue, data: Data(), error: nil, responseType: Facts.self, completion: { facts, error in
            XCTAssertTrue(error?.localizedDescription == APIError.resourceNotFound.localizedDescription)
            XCTAssertNil(facts)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testApiClientWithInCorrectResponse() {
        
        let expectation = self.expectation(description: "testApiClientWithInCorrectResponse")
        
        let urlRequest = URLRequest(url: URL(string: "https://www.example.com")!)
        apiClient?.hitAPI(with: urlRequest, responseType: Facts.self, completion: { response, error in
            XCTAssertNil(response)
            XCTAssertTrue(error?.localizedDescription == APIError.notDataIsParsed.localizedDescription || error != nil)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 60.0, handler: nil)
        
    }
    
    func testApiClientWithNoDataFromServer() {
        
        let expectation = self.expectation(description: "testApiClientWithNoDataFromServer")
        
        let urlRequest = URLRequest(url: URL(string: "https://rickandmortyapi.com/api/characteraaa")!)
        apiClient?.hitAPI(with: urlRequest, responseType: Facts.self, completion: { response, error in
            XCTAssertNil(response)
            XCTAssertTrue(error?.localizedDescription == APIError.resourceNotFound.localizedDescription || error != nil)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 60.0, handler: nil)
        
    }
    
}
