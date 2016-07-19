//
//  Case.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 12/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation

class Case {
    
    let id: Int
    let ligne: Int
    let colonne: Int
    var estEnFeu: Bool
    var imageJeu: Int
    
    init(id: Int, image: Int) {
        self.id = id
        self.imageJeu = image
        self.ligne = Int(id/nombreColonne)
        self.colonne = Int(id%nombreColonne)
        self.estEnFeu = false
    }
}