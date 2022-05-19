//
//  NewsTableViewCellViewModel.swift
//  NewsApp
//
//  Created by macbook pro on 8/4/2022.
//

import Foundation

class NewsTableViewCellViewModel {
    let title:String
    let subTitle:String
    let imageURL:URL?
    var imageDATA:Data?
    
    init(title:String,
         subTitle:String,
         imageURL:URL?){
        
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}

