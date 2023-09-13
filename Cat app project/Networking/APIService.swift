//
//  APIService.swift
//  Cat app project
//
//  Created by macbook pro on 4/9/2023.
//

import Foundation

struct APIService:APIServiceProtocol {
    
    
    func fetchBreeds(url:URL?,completion:@escaping (Result<[Breed],APIError>)->Void){
        
        guard let url = url  else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { Data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            }else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            }else {
                let decoder = JSONDecoder()
                if let data = Data {
                    do {
                        let decodededData =  try decoder.decode([Breed].self, from: data)
    //                    print(decodededData)
                        completion(Result.success(decodededData))
                    } catch  {
    //                    print(error)
                        completion(Result.failure(APIError.parsing(error as? DecodingError)))
                    }
                    
                }
            }
        }
        task.resume()
   
    }
    
    
}
