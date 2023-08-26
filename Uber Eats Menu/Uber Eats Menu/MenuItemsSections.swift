//
//  MenuItemsSections.swift
//  Uber Eats Menu
//
//  Created by macbook pro on 19/8/2023.
//

import SwiftUI

struct MenuItemsSections: View {
    let option:menuItems
    
    @Binding var currentOption : menuItems
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(option.title)
                .font(.system(size: 40, weight: .semibold, design: .default))
                .padding(.vertical,20)
            
            ForEach(option.food) { item in
                
                HStack {
                    VStack(alignment: .leading,spacing: 15) {
                        
                        Text(item.title)
                            .font(.title2)
                            .bold()
                        Text(item.description)
                            .foregroundColor(.gray)
                        
                        Text("Price : \(item.price)")
                            .font(.title3)
                            .bold()
                    }
                    
                    Spacer()
                    
                    Image(item.imageName)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                        .cornerRadius(10)
                    
                }
                
                Divider()
            }
            
        }.modifier(OffsetModifier(option: option, currentOption: $currentOption))
    }
}

//struct MenuItemsSections_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemsSections(option: .american)
//    }
//}
