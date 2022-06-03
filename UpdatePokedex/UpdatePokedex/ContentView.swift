//
//  ContentView.swift
//  UpdatePokedex
//
//  Created by Gürkan Yeşilyurt on 4.03.2022.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
   @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    var filteredPokemon: [Pokemon]{
        if searchText == "" {return pokemonVM.pokemon}
        return pokemonVM.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
   
    var body: some View {
        NavigationView{
            List {
                ForEach (filteredPokemon) {
                    pokemons in
                    NavigationLink(destination:PokemonDetailView(pokemon: pokemons)){
                      
                        HStack{
                            VStack(alignment: .leading, spacing: 5){
                               
                                HStack {
                                    Text(pokemons.name.capitalized)
                                        .font(.title)
                                    
                                    if pokemons.isFavorite{
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                              
                                                                        
                                HStack {
                                    Text(pokemons.type.capitalized)
                                        .italic()
                              
                                        
                                    Circle()
                                        .foregroundColor(pokemons.typeColor)
                                        .frame(width: 15, height: 15)
                                }
                              
                                
                            }
                            Spacer()
                            
                            KFImage(URL(string: pokemons.imageURL))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width*0.226, height:UIScreen.main.bounds.width*0.242)
                                .padding([.bottom, .trailing], 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white.opacity(0.09))
                                )
                                .shadow(color: pokemons.typeColor, radius: 10, x: 0, y: 0)
                                
                       }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button (action: {addFavorite(pokemon:pokemons)}) {
                            Image(systemName: "star")
                        }
                        .tint(.yellow)
                    }
                 }
              }
            
            .navigationTitle("Pokemon")
            .searchable(text: $searchText)
        }
        
    }
    func addFavorite(pokemon:Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where:{
            $0.id == pokemon.id } ) {
            pokemonVM.pokemon[index].isFavorite.toggle()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
