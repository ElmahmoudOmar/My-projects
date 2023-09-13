//
//  BreedDetailView.swift
//  Cat app project
//
//  Created by macbook pro on 5/9/2023.
//

import SwiftUI

struct BreedDetailView: View {
    
    let breed: Breed
    
    var body: some View {
        
        ScrollView {
            VStack {
                if  breed.image?.url != nil {
                    
                    AsyncImage(url:URL(string: (breed.image?.url)!)) { image in
                        image.resizable()
                            .frame(height: 300)
                            .scaledToFit()
                    } placeholder: {
                        Rectangle()
                            .frame(height: 300)
                            .foregroundColor(.gray)
                    }
                    
                }else {
                    Rectangle()
                        .frame(height: 300)
                        .foregroundColor(.gray)
                }
                
                VStack (alignment: .leading,spacing: 10){
                    Text(breed.name)
                        .font(.system(size: 30, weight: .bold, design: .default))
                    Text(breed.temperament)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.orange)
                    Text(breed.catDescription)
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }.padding()
                
                HStack {
                    
                    VStack (alignment: .leading,spacing: 10){
                        Text("Origin :")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                        Text("LifeSpan :")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                        Text("Rare :")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                        Text("Hairless :")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                        
                    }
                    
                    Spacer()
                    
                    
                    VStack (alignment: .trailing,spacing: 10){
                        Text(breed.origin)
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.orange)
                        Text("\(breed.lifeSpan) years")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.orange)
                        Text("\(breed.rare ? "Yes":"No")")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.orange)
                        Text("\(breed.isHairless ? "Yes":"No")")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundColor(.orange)
                        
                    }
                }.padding()
                
                Spacer()
            }
        }
        }
     
}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailView(breed: Breed.breed1())
    }
}
