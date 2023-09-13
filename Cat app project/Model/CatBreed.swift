//
//  CatBreed.swift
//  Cat app project
//
//  Created by macbook pro on 30/8/2023.
//

import Foundation



struct Breed : Codable,Identifiable {
    
    let id: String
    let name : String
    let catDescription : String
    let isHairless : Bool
    let rare : Bool
    let origin : String
    let lifeSpan : String
    let temperament : String
    let image : BreedImage?
 
    
    enum CodingKeys : String, CodingKey {

        case id
        case name
        case catDescription = "description"
        case isHairless = "hairless"
        case rare
        case origin
        case lifeSpan = "life_span"
        case temperament
        case image

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        catDescription = try values.decode(String.self, forKey: .catDescription)
        let hairless = try values.decode(Int.self, forKey: .isHairless)
        isHairless = hairless == 1
        let rare = try values.decode(Int.self, forKey: .rare)
        self.rare = rare == 1
        origin = try values.decode(String.self, forKey: .origin)
        lifeSpan = try values.decode(String.self, forKey: .lifeSpan)
        temperament = try values.decode(String.self, forKey: .temperament)
        image = try values.decodeIfPresent(BreedImage.self, forKey: .image)
    }
    
    
    init(name:String,id:String,description:String,isHairless:Bool,rare:Bool,origin:String,lifeSpan:String,temperament:String,image:BreedImage?) {
        self.name = name
        self.id = id
        self.catDescription = description
        self.isHairless = isHairless
        self.rare = rare
        self.origin = origin
        self.lifeSpan = lifeSpan
        self.temperament = temperament
        self.image = image
        
        
    }
    
    // Mock data
    
    static func breed1()-> Breed {
        let breed = Breed(name: "Abyssinian", id: "abys", description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.", isHairless: false, rare: false, origin: "Egypt", lifeSpan: "14 - 15", temperament: "Active, Energetic, Independent, Intelligent, Gentle", image: nil)
        return breed
    }
    
    static func breed2()-> Breed {
        let breed = Breed(name: "Aegean", id: "aege", description: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.", isHairless: false, rare: false, origin: "Greece", lifeSpan: "9 - 12", temperament: "Affectionate, Social, Intelligent, Playful, Active", image: nil)
        return breed
    }
    
    
    
 
}




