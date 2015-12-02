//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Nathan McGuire on 30/11/2015.
//  Copyright © 2015 Nathan McGuire. All rights reserved.
//

import UIKit



class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoTextLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexID)")
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
            
        }
    }
    
    func updateUI() {
        descLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        pokedexIDLbl.text = "\(pokemon.pokedexID)"
        defenseLbl.text = pokemon.defense
        baseAttLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        nameLabel.text = "\(pokemon.name.capitalizedString)"
        
        if pokemon.nextEvolutionID == "" {
            evoTextLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
            currentEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            currentEvoImg.hidden = false
            currentEvoImg.image = UIImage(named: "\(pokemon.pokedexID)")
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionID)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                evoTextLbl.text = str
            }
        }
        }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    }




    


