//
//  ApiResponse.swift
//  NewsApp
//
//  Created by macbook pro on 8/4/2022.
//

import Foundation


struct ApiResponse:Decodable {
    
   let articles:[Article]
    
}

struct Article:Decodable {
    
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
    let source: Source
}

struct Source:Decodable {
    let name:String?
}






