//
//  BreedFetcher.swift
//  Cat app project
//
//  Created by macbook pro on 3/9/2023.
//

import Foundation


class BreedFetcher : ObservableObject {
    
    @Published var breeds =  [Breed]()
    @Published var errorMessage : String? = nil
    @Published var isLoading : Bool = false
    
    let service : APIServiceProtocol
    
    init(service:APIServiceProtocol = APIService()) {
        
        self.service = service
        fetchAllBreeds()
        
    }
    
    
    func fetchAllBreeds(){
        
        isLoading = true
        errorMessage = nil
        
        let apiKey = "?api_key=live_G8J7AM5AeN5CZrJSROhfNpb223YBln64oqU0J7wCk7tl3RoHu7tBu4Jvs6nXrbTP"
        let baseUrl = "https://api.thecatapi.com/v1/breeds"
        
        let url = URL(string: baseUrl + apiKey)
      
        service.fetchBreeds(url: url) {[weak self] result in
            
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let breeds):
                    self?.breeds = breeds
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(error.description)
                }
            }
        }
        
        
        
    }
    
    
    //MARK: preview helpers
    
    
    static func errorState()-> BreedFetcher {
        
        let fetcher = BreedFetcher()
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return fetcher
    }
    
    static func successState()-> BreedFetcher {
        
        let fetcher = BreedFetcher()
        fetcher.breeds = [Breed.breed1(),Breed.breed2()]
        return fetcher
    }
    
    
    
    
    
}


