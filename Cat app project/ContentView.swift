//
//  ContentView.swift
//  Cat app project
//
//  Created by macbook pro on 30/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var breedFetcher = BreedFetcher()
    
    var body: some View {
        if breedFetcher.errorMessage != nil {
            ErrorView(breedFetcher: breedFetcher)
        } else if breedFetcher.isLoading == true {
            LoadingView()
        } else {
            BreedListView(breeds: breedFetcher.breeds)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
