//
//  MenuItemsDataModel.swift
//  Uber Eats Menu
//
//  Created by macbook pro on 14/8/2023.
//

import Foundation



struct FoodItem : Identifiable {
    
    let id = UUID().uuidString
    let title : String
    let description : String
    let price: String
    let imageName : String
    
}

// Mock data

let americanFood = [
                    FoodItem(title: "Meatball", description: "This meatball dish is cooked with a tomato sauce and parmesan cheese.", price: "$30", imageName: "american1"),
                    FoodItem(title: "Tuna", description: "experience the freshness of the Tuna dish with sweet potato and lemon juice sauce.", price: "$40", imageName: "american2"),
                    FoodItem(title: "Classic hamburger", description: "Enjoy the classic American hamburger with fried potatoes and a tasty steak with melted cheese on top.", price: "$25", imageName: "american3"),
                    FoodItem(title: "Chiken salad", description: "Enjoy roasted chikens with a great and fresh salad.", price: "$20", imageName: "american4")
                    ]

let chineseFood = [
                    FoodItem(title: "Noodles", description: "This Noodles dish is cooked with noodles and eggs and spinach.", price: "$16", imageName: "chinese2"),
                    FoodItem(title: "Sushi", description: "experience this amazing sushi dish with salmon and avocado.", price: "$40", imageName: "chinese1"),
                    FoodItem(title: "Sushi rolls", description: "Enjoy Sushi rolls dish with teriyaki sauce and wasabi, you will love it.", price: "$35", imageName: "chinese3")
                    ]

let italianFood = [
                    FoodItem(title: "Alfredo pasta", description: "It's robust, hearty, and filled with warm and comforting flavors like Alfredo sauce with tomato.", price: "$36", imageName: "italian1"),
                    FoodItem(title: "Roasted bread", description: "experience this amazing roasted bread with creamy feta cheese and sweet tomatoes, it's so tasty.", price: "$33", imageName: "italian2"),
                    FoodItem(title: "Tuna pizza", description: "Enjoy tuna pizza with parmesan cheese and ananas, you will love it.", price: "$40", imageName: "italian3")
                    ]

let dessertFood = [
                    FoodItem(title: "Raspberry cheesecake", description: "This is a tasty, hearty dish of dessert, it's filled with Sweet flavors like caramelized raspberry with cream cheese filling.", price: "$28", imageName: "dessert1"),
                    FoodItem(title: "Strawberry creamcheese", description: "experience this fresh strawberry fruit on top of a creamcheese filling with vanilla flavor, it's so tasty.", price: "$20", imageName: "dessert3"),
                    FoodItem(title: "Sweet pancake", description: "Enjoy this fluffy pancake with honey and butter on top of it, you will love it.", price: "$25", imageName: "dessert2")
                    ]



enum menuItems : CaseIterable {
    case american
    case italian
    case chinese
    case dessert
    case bestOnes
    
    var title : String {
        
        switch self {
            
        case .american : return "American"
        case .italian : return "Italian"
        case .chinese: return "Chinese"
        case .dessert: return "Dessert"
        case .bestOnes: return "BestOnes"
            
        }
        
        
    }
    
    var food:[FoodItem] {
        
        switch self {
        case .american:
            return americanFood
        case .italian:
            return italianFood
        case .chinese:
            return chineseFood
        case .dessert:
            return dessertFood
        case .bestOnes:
            return italianFood + americanFood
        }
    }
    
    
}
