//
//  Tile.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/07/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit

enum Tile: Int {
    
    case Ground
    case Wall
    case Arbre1
    case Building1
    case Fire
    case Avion
    case Eau
    case Canadaire
    case Retardant
    case Arbre2
    case Arbre3
    case Arbre4
    case Building2
    case Building3
    case Building4
    case Building5
    case Building6
    
    var description:String {
        switch self {
        case Ground:
            return "Ground"
        case Wall:
            return "Wall"
        case Arbre1:
            return "Arbre1"
        case Building1:
            return "Building1"
        case Fire:
            return "Fire"
        case Avion:
            return "Avion"
        case Eau:
            return "Eau"
        case Canadaire:
            return "Canadaire"
        case Retardant:
            return "Retardant"
        case Arbre2:
            return "Arbre2"
        case Arbre3:
            return "Arbre3"
        case Arbre4:
            return "Arbre4"
        case Building2:
            return "Building2"
        case Building3:
            return "Building3"
        case Building4:
            return "Building4"
        case Building5:
            return "Building5"
        case Building6:
            return "Building6"
        }
    }
    
    var image:SKSpriteNode {
        switch self {
        case Ground:
            let ground = SKSpriteNode(imageNamed: "sol")
            ground.name = kSpriteTouchable
            return ground
        case Wall:
            let wall = SKSpriteNode(imageNamed: "wall")
            wall.name = kSpriteNotTouchable
            return wall
        case Arbre1:
            let arbre = SKSpriteNode(imageNamed: "arbre1")
            arbre.name = kSpriteTouchable
            return arbre
        case Building1:
            let maison = SKSpriteNode(imageNamed: "building1")
            maison.name = kSpriteNotTouchable
            return maison
        case Fire:
            let feu = SKSpriteNode(imageNamed: "feu")
            feu.name = kSpriteNotTouchable
            return feu
        case Avion:
            let avion = SKSpriteNode(imageNamed: "Avion")
            return avion
        case Eau:
            let water = SKSpriteNode(imageNamed: "eau")
            water.name = kSpriteTouchable
            return water
        case Canadaire:
            let icon = SKSpriteNode(imageNamed: "icon2")
            return icon
        case Retardant:
            let ret = SKSpriteNode(imageNamed: "icon3")
            return ret
        case Arbre2:
            let arbre = SKSpriteNode(imageNamed: "arbre2")
            arbre.name = kSpriteTouchable
            return arbre
        case Arbre3:
            let arbre = SKSpriteNode(imageNamed: "arbre3")
            arbre.name = kSpriteTouchable
            return arbre
        case Arbre4:
            let arbre = SKSpriteNode(imageNamed: "arbre4")
            arbre.name = kSpriteTouchable
            return arbre
        case Building2:
            let maison = SKSpriteNode(imageNamed: "building2")
            maison.name = kSpriteNotTouchable
            return maison
        case Building3:
            let maison = SKSpriteNode(imageNamed: "building3")
            maison.name = kSpriteNotTouchable
            return maison
        case Building4:
            let maison = SKSpriteNode(imageNamed: "building4")
            maison.name = kSpriteNotTouchable
            return maison
        case Building5:
            let maison = SKSpriteNode(imageNamed: "building5")
            maison.name = kSpriteNotTouchable
            return maison
        case Building6:
            let maison = SKSpriteNode(imageNamed: "building6")
            maison.name = kSpriteNotTouchable
            return maison
        }
    }
}

