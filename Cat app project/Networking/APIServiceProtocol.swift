//
//  APIServiceProtocol.swift
//  Cat app project
//
//  Created by macbook pro on 6/9/2023.
//

import Foundation


protocol APIServiceProtocol {
    
    func fetchBreeds(url:URL?,completion:@escaping (Result<[Breed],APIError>)->Void)
}
