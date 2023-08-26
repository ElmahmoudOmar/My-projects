//
//  OffsetModifier.swift
//  Uber Eats Menu
//
//  Created by macbook pro on 20/8/2023.
//

import Foundation

import SwiftUI

struct OffsetModifier: ViewModifier {

    let option : menuItems
    @Binding var currentOption : menuItems
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("section")))
                }
            }.onPreferenceChange(OffsetKey.self) { proxy in
                let offset = proxy.minY
                withAnimation {
                    currentOption = (offset < 20 && -offset < (proxy.midX / 2) && currentOption != option) ? option : currentOption

                }
            }
    }
    
}
