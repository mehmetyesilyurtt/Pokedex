//
//  StartView.swift
//  UpdatePokedex
//
//  Created by Gürkan Yeşilyurt on 4.03.2022.
//

import SwiftUI

struct StatView: View {
    var pokemon: Pokemon
    var statName: String
    var statColor: Color
    var statValue: Int
    
    var body: some View {
        HStack{
         Text(statName)
              .font(.system(.body, design: .monospaced))
            ZStack(alignment: .leading){
               
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(statColor)
                    .frame(width: statValue <= 100 ? 150 * (CGFloat(statValue)/100) : 150, height: 20)
            }
            
            Text("\(statValue)")
                .font(.system(.body,design: .monospaced))
        }
    }
}


