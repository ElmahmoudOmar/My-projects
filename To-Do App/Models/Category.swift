//
//  Category.swift
//  To-do
//
//  Created by macbook pro on 14/1/2023.
//

import Foundation
import RealmSwift


class Category:Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
