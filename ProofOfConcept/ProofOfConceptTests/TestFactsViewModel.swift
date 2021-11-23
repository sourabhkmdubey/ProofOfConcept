//
//  TestFactsViewModel.swift
//  ProofOfConceptTests
//
//  Created by Sourabh Dubey on 19/11/21.
//

import XCTest
@testable import ProofOfConcept

class TestFactsViewModel: XCTestCase {
    
    var viewModel: FactsViewModelProtocol?
    override func setUp() {
        super.setUp()
        viewModel = FactsViewModel()
    }
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    
    func testCallFactsApi() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testCallFactsApi")
        // reloadListClosure will call after geting response from Fact api which called in init block
        viewModel.reloadListClosure = {
            XCTAssertTrue(viewModel.factData != nil)
            expectation.fulfill()
        }
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
    func testNumberOfFactsCount() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testNumberOfFactsCount")
        viewModel.reloadListClosure = {
            XCTAssertTrue(viewModel.numberOfFactsCount() > 0)
            XCTAssertFalse(viewModel.numberOfFactsCount() <= 0)
            expectation.fulfill()
        }
        
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
    func testGetFactsDetailsTitle() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testGetFactsDetailsTitle")
        viewModel.reloadListClosure = {
            XCTAssertTrue(viewModel.getFactsDetailsTitle(0) == "Beavers")
            expectation.fulfill()
        }
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
    func testGetFactsDetailsDesc() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testGetFactsDetailsDesc")
        viewModel.reloadListClosure = {
            // swiftlint:disable:next line_length
            XCTAssertTrue(viewModel.getFactsDetailsDesc(0) == "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony")
            expectation.fulfill()
        }
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
    func testGetFactsImage() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testGetFactsImage")
        viewModel.reloadListClosure = {
            XCTAssertTrue(viewModel.getFactsImage(0) == "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
            expectation.fulfill()
        }
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
    func testRefreshFactApi() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testRefreshFactApi")
        viewModel.reloadListClosure = {
            XCTAssertTrue(viewModel.factData != nil)
            expectation.fulfill()
        }
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
    func testGetHeaderTitle() {
        
        guard let viewModel = self.viewModel else { return }
        //automatically call fact api in init
        let expectation = self.expectation(description: "testGetHeaderTitle")
        viewModel.reloadListClosure = {
            XCTAssertTrue(viewModel.getHeaderTitle() == "About Canada")
            expectation.fulfill()
        }
        viewModel.errorClosure = { error in
            XCTAssertTrue(error != nil)
            expectation.fulfill()
        }
        viewModel.callFactsApi()
        waitForExpectations(timeout: 60 + 1, handler: nil)
    }
    
}


class MockFactsViewModel {
    
}




