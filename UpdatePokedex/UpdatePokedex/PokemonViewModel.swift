//
//  PokemonModel.swift
//  UpdatePokedex
//
//  Created by Gürkan Yeşilyurt on 4.03.2022.
//


import SwiftUI

struct Pokemon : Identifiable,Decodable {
    
let pokeID = UUID()
    var isFavorite = false
    
    let id : Int
    let name : String
    let imageURL : String
    let type : String
    let description : String
    
    let attack : Int
    let defense : Int
    let height : Int
    let weight : Int
    
    
    private enum CodingKeys: String, CodingKey
    {
    
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case description
        case attack
        case defense
        case height
        case weight
    }
    
    var typeColor:Color{
        switch type {
        case "grass":
            return Color(.systemGreen)
        case "fire":
            return Color(.systemRed)
        case "posion":
            return Color(.systemPurple)
        case "water":
            return Color(.systemBlue)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemMint)
        case "normal":
            return Color(.systemGray)
        case "ground":
            return Color(.systemBrown)
        case "flaying":
            return Color(.systemGray4)
        case "fairy":
            return Color(.systemPink)
        default:
            return Color(.systemIndigo)
        }
    }
    
    
}

enum FetchError: Error{
    case badURL
    case badResponse
    case badData
}
class PokemonViewModel :ObservableObject{
    @Published var pokemon = [Pokemon]()
    
    init (){
        Task {
            pokemon = try await getPokemon()
        }
    }
    
    
    func getPokemon() async throws -> [Pokemon]{
        
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json") else{
            throw FetchError.badURL
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
       
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{ throw FetchError.badResponse}
        guard let data = data.removeNullsFrom(string: "null,") else {throw FetchError.badData}
       
        let maybePokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        
        return maybePokemonData
    }
    
    
    
    
}
extension Data {

    func removeNullsFrom(string:String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8)else {return nil}
        return data
    }
}
