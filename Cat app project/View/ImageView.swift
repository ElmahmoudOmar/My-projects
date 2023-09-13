//
//  ImageView.swift
//  Cat app project
//
//  Created by macbook pro on 7/9/2023.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var imageLoader : ImageLoader
    
    init(url:String?) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            } else if imageLoader.isLoading == true {
                ProgressView()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(uiColor: .systemGray5))
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(uiColor: .systemGray5))
                    .cornerRadius(10)
            }
        }.onAppear {
            imageLoader.fetch()
        }
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: nil)
    }
}
