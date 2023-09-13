//
//  BreedRow.swift
//  Cat app project
//
//  Created by macbook pro on 5/9/2023.
//

import SwiftUI

struct BreedRowView: View {
    
    let breed:Breed
    
    var body: some View {
        HStack {
            
            if  breed.image?.url != nil {
                
                ImageView(url: breed.image?.url!)
                
            }else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(uiColor: .systemGray5))
            }
           
            VStack(alignment: .leading) {
                Text(breed.name)
                    .font(.system(size: 20, weight: .medium, design: .default))
                Text(breed.temperament)
                    .font(.body)
            }.padding(.leading,8)
            
        }.padding(.vertical)
    }
}

struct BreedRow_Previews: PreviewProvider {
    static var previews: some View {
        BreedRowView(breed: Breed.breed1())
    }
}
