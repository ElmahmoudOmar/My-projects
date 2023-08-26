//
//  ContentView.swift
//  Uber Eats Menu
//
//  Created by macbook pro on 14/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedMenuItem: menuItems
    @State var currentOption : menuItems = .american
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                }
                
                Text("La Vue Menu - Tangier")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                }
            }.padding(.horizontal)
                .foregroundColor(.black)
            
            MenuItems(selectedMenuItem: $selectedMenuItem, currentOption: $currentOption)
                .overlay(alignment: .bottom) {
                Divider()
                    .padding(.horizontal,-10)
            }
                .padding(.vertical)
                
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        ForEach(menuItems.allCases, id: \.self) { item in
                    
                            MenuItemsSections(option:item, currentOption: $currentOption)
                        }
                    }.padding(.horizontal)
                        .onChange(of: selectedMenuItem) { _ in
                            withAnimation(.easeInOut){
                                proxy.scrollTo(selectedMenuItem, anchor: .top)
                            }
                        }
                }.coordinateSpace(name: "section")
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedMenuItem: .american)
    }
}
