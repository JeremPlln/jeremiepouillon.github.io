//
//  LevelScene.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 09/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class LevelScene: SKScene {
    
    //    let cigaretteMode = UIButton()
    //    let criminelMode = UIButton()
    //    let foudreMode = UIButton()
    //    let tutorialMode = UIButton()
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "FondEcran2.png")
        background.size.width = self.view!.bounds.width
        background.size.height = self.view!.bounds.height
        background.anchorPoint = CGPoint(x:0, y:0)
        self.addChild(background)
        
        addButtons()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        var secondScene = GameScene(size: self.size, typeJeu: 1)
        var goToTutoriel = TutorialScene()
        
        switch node.name {
        case "BoutonModeCigarette"? :
            secondScene = GameScene(size: self.size, typeJeu: 1)
        case "BoutonModeFoudre"? :
            secondScene = GameScene(size: self.size, typeJeu: 2)
        case "BoutonModeCriminel"? :
            secondScene = GameScene(size: self.size, typeJeu: 3)
        default:
            goToTutoriel = TutorialScene(size: self.size)
        }
        if(node.name == "BoutonModeCigarette" || node.name == "BoutonModeFoudre" || node.name == "BoutonModeCriminel"){
            gameIsRunning = true
            let transition = SKTransition.fadeWithDuration(1.0)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(secondScene, transition: transition)
        }
        else{
            let transition = SKTransition.fadeWithDuration(1.0)
            goToTutoriel.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(goToTutoriel, transition: transition)
        }
    }
    
    private func addButtons() {
        // TODO layout buttons here
        let Titre = SKSpriteNode(imageNamed: "nomJeu.png")
        Titre.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (view?.bounds.height)!/2.5)
        Titre.zPosition = 2
        self.addChild(Titre)
        
        let bouttonModeCigarette = SKSpriteNode(imageNamed: "BouttonCigaretteMode.png")
        bouttonModeCigarette.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        bouttonModeCigarette.name = "BoutonModeCigarette"
        bouttonModeCigarette.zPosition = 2
        bouttonModeCigarette.size = CGSize(width: 100, height: 50)
        self.addChild(bouttonModeCigarette)
        
        let bouttonModeTutoriel = SKSpriteNode(imageNamed: "BouttonTutoriel.png")
        bouttonModeTutoriel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+55)
        bouttonModeTutoriel.name = "BoutonModeTutoriel"
        bouttonModeTutoriel.zPosition = 2
        bouttonModeTutoriel.size = CGSize(width: 100, height: 50)
        self.addChild(bouttonModeTutoriel)
        
        let bouttonModeFoudre = SKSpriteNode(imageNamed: "BouttonFoudre.png")
        bouttonModeFoudre.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 55)
        bouttonModeFoudre.name = "BoutonModeFoudre"
        bouttonModeFoudre.zPosition = 2
        bouttonModeFoudre.size = CGSize(width: 100, height: 50)
        self.addChild(bouttonModeFoudre)
        
        let bouttonModeCriminel = SKSpriteNode(imageNamed: "BouttonCriminel.png")
        bouttonModeCriminel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 110)
        bouttonModeCriminel.name = "BoutonModeCriminel"
        bouttonModeCriminel.zPosition = 2
        bouttonModeCriminel.size = CGSize(width: 100, height: 50)
        self.addChild(bouttonModeCriminel)
    }
    
    
}