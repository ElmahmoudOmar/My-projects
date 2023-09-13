//
//  BreedListView.swift
//  Cat app project
//
//  Created by macbook pro on 4/9/2023.
//

import SwiftUI

struct BreedListView: View {
    
    var breeds : [Breed]
    @State private var searchText: String = ""
    
    var filteredBreeds : [Breed] {
        
        if searchText.count == 0 {
            return breeds
        }else{
            return breeds.filter{$0.name.contains(searchText)}
        }
    }
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(filteredBreeds) { breed in
                    NavigationLink {
                        BreedDetailView(breed: breed)
                    } label: {
                        BreedRowView(breed: breed)
                    }
                }
            }.navigationTitle("Explore Cat Breeds")
                .listStyle(.plain)
                .searchable(text: $searchText)
        }.onAppear {
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
       
    }
}

struct BreedListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView(breeds: BreedFetcher.successState().breeds)
    }
}
