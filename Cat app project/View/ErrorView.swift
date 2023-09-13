//
//  ErrorView.swift
//  Cat app project
//
//  Created by macbook pro on 4/9/2023.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var breedFetcher : BreedFetcher
    
    var body: some View {
        VStack {
            Text("😿")
                .font(.system(size: 100))
            Text("Ooops, somthing went wrong!")
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(Color(uiColor: .systemGray))
            
            Button {
                
                breedFetcher.fetchAllBreeds()
                
            } label: {
                Text("Try again")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(.orange)
                    .underline()
            }

            
        }
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(breedFetcher: BreedFetcher())
    }
}
