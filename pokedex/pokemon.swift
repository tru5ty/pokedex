//
//  pokemon.swift
//  pokedex
//
//  Created by Nathan McGuire on 30/11/2015.
//  Copyright © 2015 Nathan McGuire. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _attack: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response -> Void in
            
            //print(response.result) // Returned proper result
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
            
                print("Height is: \(self.height)")
                print("Weight is: \(self.weight)")
                print("Attack is: \(self.attack)")
                print("Defense is: \(self.defense)")
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            
                        }
                    }
                }
            } else {
                self._type = ""
            }
            print("Type is: \(self.type)") // success
            
        if let descArr = dict["types"] as? [Dictionary<String, String>] where descArr.count > 0 {
                
            if let url = descArr[0]["resource_uri"] {
                let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                    
                Alamofire.request(.GET, nsurl).responseJSON { response -> Void in
                
                    let descResult = response.result.value
                    if let descDict = descResult as? Dictionary<String, AnyObject> {
                        if let description = descDict["description"] as? String {
                            self._description = description
                            print(self._description)
                            }
                        }
                        completed()
                }
                
                }
                
            } else {
                self._description = ""
            }
        
            if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                if let to = evolutions[0]["to"] as? String {
                    // Cannot support 'mega' evolutions in API
                    if to.rangeOfString("mega") == nil {
                        if let uri = evolutions[0]["resource_uri"] as? String {
                            let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                            let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                            self._nextEvolutionID = num
                            self._nextEvolutionTxt = to
                                
                            if let lvl = evolutions[0]["level"] as? Int {
                                self._nextEvolutionLvl = "\(lvl)"
                            }
                            
                            print(self.nextEvolutionID)
                            print(self.nextEvolutionLvl)
                            print(self.nextEvolutionTxt)
                        }
                    }
                }
            }
            
        }
    }

    }

    
}