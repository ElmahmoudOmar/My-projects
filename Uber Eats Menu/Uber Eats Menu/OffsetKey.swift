//
//  OffsetKey.swift
//  Uber Eats Menu
//
//  Created by macbook pro on 20/8/2023.
//

import Foundation
import SwiftUI

struct OffsetKey : PreferenceKey {

    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
    
}
