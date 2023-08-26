//
//  MenuItems.swift
//  Uber Eats Menu
//
//  Created by macbook pro on 14/8/2023.
//

import SwiftUI

struct MenuItems: View {
    
    @Binding var selectedMenuItem: menuItems
    @Binding var currentOption : menuItems
    @Namespace var animation
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(menuItems.allCases,id: \.self) { item in
                        
                        VStack {
                            Text(item.title)
                                .font(.system(size: 20))
                                .bold()
                            .foregroundColor(currentOption == item ? .black : .gray)
                            
                            if currentOption == item {
                                
                                Capsule()
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "item", in: animation)
                                    .frame(height: 3)
                            } else {
                                
                                Capsule()
                                    .fill(.clear)
                                    .frame(height: 3)
                            }
                            
                        }.onTapGesture {
                            withAnimation(.easeInOut) {
                                self.selectedMenuItem = item
                                proxy.scrollTo(item, anchor: .topTrailing)
                            }
                        }
                    }.onChange(of: currentOption) { _ in
                        withAnimation {
                            proxy.scrollTo(currentOption, anchor: .topTrailing)
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}

//struct MenuItems_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItems(selectedMenuItem: .constant(.american))
//    }
//}
