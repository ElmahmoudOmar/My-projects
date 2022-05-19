//
//  ApiCaller.swift
//  NewsApp
//
//  Created by macbook pro on 7/4/2022.
//

import Foundation

final class APICaller {
    
  static  let shared = APICaller()
    
    struct Constants {
        static let newsApiUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=fa5f01377a084a0f8ea74f1f68a50934")
        static let searchURL = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=fa5f01377a084a0f8ea74f1f68a50934&q="
    }
    
    
    
    public func getTopNews(completion:@escaping (Result<[Article],Error>)-> Void){
        
        guard let  url = Constants.newsApiUrl else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result =  try JSONDecoder().decode(ApiResponse.self, from: data)
                    completion(.success(result.articles))
                } catch  {
                    completion(.failure(error))
                }
                
            }
        }
        task.resume()
    }
    
    public func serach(for query : String, completion:@escaping (Result<[Article],Error>)-> Void){
        
        let urlString = Constants.searchURL + query
        guard let  url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result =  try JSONDecoder().decode(ApiResponse.self, from: data)
                    completion(.success(result.articles))
                } catch  {
                    completion(.failure(error))
                }
                
            }
        }
        task.resume()
    }
    
    
}
