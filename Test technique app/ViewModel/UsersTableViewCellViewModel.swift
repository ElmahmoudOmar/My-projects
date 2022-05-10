//
//  UsersTableViewCellViewModel.swift
//  Test technique app
//
//  Created by macbook pro on 9/5/2022.
//

import Foundation

class UsersTableViewCellViewModel {
    let id:Int
    let name:String
    let username:String
    var email:String
    
    init(id:Int,
         name:String,
         username:String,
         email:String){
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
    }
}
