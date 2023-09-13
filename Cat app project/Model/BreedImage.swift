//
//  BreedImage.swift
//  Cat app project
//
//  Created by macbook pro on 30/8/2023.
//

import Foundation

struct BreedImage : Codable,Identifiable {

    let id : String?
    let width : Int?
    let height : Int?
    let url : String?
}
