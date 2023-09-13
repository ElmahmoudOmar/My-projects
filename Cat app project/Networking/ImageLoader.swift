//
//  ImageLoader.swift
//  Cat app project
//
//  Created by macbook pro on 7/9/2023.
//

import Foundation
import UIKit

class ImageLoader : ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var errorMessage : String? = nil
    @Published var isLoading : Bool = false
    
    
    let url : String?
    
    init(url:String?){
        
        self.url = url
    }
    
    func fetch(){
        
        guard image == nil && !isLoading else {return}
        
        
        guard let url = url, let fetchURL = URL(string: url) else {
            errorMessage = APIError.badURL.localizedDescription
            return
        }
        
        errorMessage = nil
        isLoading = true
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] Data, response, error in
            
            DispatchQueue.main.async {
                
                self?.isLoading = false
                
                if let error = error as? URLError {
                    self?.errorMessage = APIError.url(error).localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                    self?.errorMessage = APIError.badResponse(statusCode: response.statusCode).localizedDescription
                } else if let data = Data, let image = UIImage(data: data) {
                        self?.image = image
                } else {
                    self?.errorMessage = APIError.unknown.localizedDescription
                }
                }
            }
            task.resume()
     
        }
      
        
    }
    

