//
//  PokemonImage.swift
//  UpdatePokedex
//
//  Created by Gürkan Yeşilyurt on 4.03.2022.
//

import SwiftUI
import Kingfisher
struct PokemonImage: View {
    var image: KFImage

    var body: some View {
        image
            .resizable()
            .scaledToFit().frame(width: 150, height: 150)
            .frame(width: 200, height: 200)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white,lineWidth: 3))
            .background(Capsule().foregroundColor(.white))
            .shadow(color:.white, radius: 5,  y: 0.2)
            .shadow(color:.black, radius: 5,  y: -0.2)
        
    }
}


