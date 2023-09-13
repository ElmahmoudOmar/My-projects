//
//  LoadingView.swift
//  Cat app project
//
//  Created by macbook pro on 4/9/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("😸")
                .font(.system(size: 100))
            Text("Loading...")
                .font(.system(size: 28, weight: .regular, design: .default))
                .foregroundColor(.gray)
            ProgressView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
