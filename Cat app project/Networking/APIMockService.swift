//
//  APIMockService.swift
//  Cat app project
//
//  Created by macbook pro on 6/9/2023.
//

import Foundation


struct APIMockService : APIServiceProtocol {
    
    var result : Result<[Breed],APIError>
    
    func fetchBreeds(url: URL?, completion: @escaping (Result<[Breed], APIError>) -> Void) {
        completion(result)
    }
    
    
}
