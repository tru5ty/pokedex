//
//  pokemon.swift
//  pokedex
//
//  Created by Nathan McGuire on 30/11/2015.
//  Copyright © 2015 Nathan McGuire. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
    
}