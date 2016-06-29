//
//  Constants.swift
//  AlbertaIsDying
//
//  Created by Pouillon Jérémie on 15/05/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import UIKit
import SpriteKit

let kSpriteTouchable = "touchable"    //SpriteNode qui peuvent être touchés
let kSpriteNotTouchable = "notTouchable"  //SpriteNode qui ne peuvent pas être touchés
let kSpriteCanadaire = "Canadaire"
let tableauFeuCount = 200
let tileSize = (width:32, height:32)
var kLIGNE = Int()
var kCOLONNE = Int()
var kCASE_SELECTIONNEE = Int()
var nombreLigne: Int = 10
var nombreColonne: Int = 20
var positionCaseFire = [CGPoint]()
var view2D = SKSpriteNode()
var compteurUniteEau : Int = 5
var compteurUniteEauDepart : Int = 5
var compteurUniteVie = Int()
let compteurUniteVieDepart: Int = 5
var compteurUniteCanadaire: Int = 0
var compteurUniteCanadaireDepart: Int = 0
var compteurUniteRetardant: Int = 0
var compteurUniteCRetardantDepart: Int = 0
var isCanadaireTouched: Bool = Bool()
var isRetardantTouched: Bool = false
var toucheCase = UITapGestureRecognizer()
var buttonsCanadaire = [ALRadialMenuButton]()
var gameIsRunning = Bool()
var isStarted = false
var isGameOver = false
var scoreVie = Int()
var scorePompier = Int()
var scoreCanadaire = Int()
var scoreRetardant = Int()
var scoreTotal = Int()
var abscisse = CGFloat()
var ordonnee = CGFloat()
let newPlateau = PlateauDeJeu()
var pompierUse: Int = 0
var canadaireUse: Int = 0
var retardantUse: Int = 0






