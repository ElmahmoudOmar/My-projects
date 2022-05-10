//
//  ApiCaller.swift
//  Test technique app
//
//  Created by macbook pro on 9/5/2022.
//

import Foundation


 enum NetworkingErrors:Error {
    
    case invalidURL
    case urlsessionError
    case decodingProblem
}

final class ApiCaller {
    
    static let shared = ApiCaller()
    
    struct ApiUrls {
        static let usersApiURL = URL(string:"https://jsonplaceholder.typicode.com/users/")
        static let todosApiURL = "https://jsonplaceholder.typicode.com/todos?userId="
    }
    
    public func getUsers (completion:@escaping (Result<[User],NetworkingErrors>)-> Void) {
        
        guard let  url = ApiUrls.usersApiURL else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(.failure(.urlsessionError))
            } else if let data = data {
                
                do {
                    let result =  try JSONDecoder().decode([User].self, from: data)
                    completion(.success(result))
                } catch  {
                    completion(.failure(.decodingProblem))
                }
                
            }
        }
        task.resume()
        
    }
    
    
    
    public func getUserTasks ( id :Int ,completion:@escaping (Result<[Todos],NetworkingErrors>)-> Void) {
        
        guard let  url = URL(string: ApiUrls.todosApiURL + "\(id)") else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(.failure(.urlsessionError))
            } else if let data = data {
                do {
                    let result =  try JSONDecoder().decode([Todos].self, from: data)
                    completion(.success(result))
                } catch  {
                    completion(.failure(.decodingProblem))
                }
                
            }
        }
        task.resume()
        
    }
    
    
}
