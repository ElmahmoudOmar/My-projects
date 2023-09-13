//
//  APIError.swift
//  Cat app project
//
//  Created by macbook pro on 4/9/2023.
//

import Foundation


enum APIError : Error, CustomStringConvertible {
 
    case badURL
    case badResponse(statusCode:Int)
    case url (URLError)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        // user feedback
        switch self {
        case .badURL,.unknown,.parsing:
            return "Sorry, somthing went wrong."
        case .badResponse(_):
            return "Sorry, the connection to  our server failed."
        case .url(let error):
            return error.localizedDescription
        }
        
    }
    var description: String {
        // info for debugging
        
        switch self {
        case .badURL:
            return "invalid URL"
        case .badResponse(let statusCode):
            return "bad response with status code \(statusCode)"
        case .url(let Error):
            return Error.localizedDescription
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "decoding problem")"
        case .unknown:
            return "unknown"
        }
    }
    
    
}
