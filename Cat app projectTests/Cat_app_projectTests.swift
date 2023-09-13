//
//  Cat_app_projectTests.swift
//  Cat app projectTests
//
//  Created by macbook pro on 30/8/2023.
//

import XCTest
import Combine
@testable import Cat_app_project

final class Cat_app_projectTests: XCTestCase {

    override func setUp() {
        
    }
    
    override func tearDown() {
        subscriptions = []
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    func test_getting_breed_successfully() {
        let result = Result<[Breed],APIError>.success([Breed.breed1()])
        let fetcher = BreedFetcher(service: APIMockService(result: result))
        
        let promise = expectation(description: "getting breeds")
        
        fetcher.$breeds.sink { breeds in
            if breeds.count > 0 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise], timeout: 2)
    }
    
    func test_getting_breed_unsuccessfully() {
        let result = Result<[Breed],APIError>.failure(APIError.badURL)
        let fetcher = BreedFetcher(service: APIMockService(result: result))
        
        let promise = expectation(description: "error message")
        
        fetcher.$errorMessage.sink { errorMessage in
            if errorMessage != nil {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise], timeout: 2)
    }

}
