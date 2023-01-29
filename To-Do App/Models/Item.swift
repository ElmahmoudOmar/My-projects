//
//  Item.swift
//  To-do
//
//  Created by macbook pro on 14/1/2023.
//

import Foundation
import RealmSwift

class Item:Object {
    
    @objc dynamic var title:String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    @objc dynamic var color: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
