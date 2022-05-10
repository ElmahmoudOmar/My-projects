//
//  ApiResponse1.swift
//  Test technique app
//
//  Created by macbook pro on 9/5/2022.
//

import Foundation

struct User:Decodable {
    let id:Int?
    let name:String?
    let username:String?
    let email:String?
}
