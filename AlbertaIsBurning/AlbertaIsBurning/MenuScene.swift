//
//  MenuScene.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 09/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    var cigaretteTxt: UITextView = UITextView()
    let str = "feu de cigarette"
    var imageMenu: UIImageView = UIImageView()
    var image: UIImage = UIImage(named: "FondEcran2.png")!
    let button = UIButton()
    
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "FondEcran2.png")
        background.size.width = self.view!.bounds.width
        background.size.height = self.view!.bounds.height
        background.anchorPoint = CGPoint(x:0, y:0)
        self.addChild(background)
        
        addButtons()
        addLabel()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        // If next button is touched, start transition to second scene
        let secondScene: LevelScene
        
        switch node.name {
        case "goToLevelScene"? :
            secondScene = LevelScene(size: self.size)
        case "goToScoreScene"? :
            secondScene = LevelScene(size: self.size)
        default:
            secondScene = LevelScene(size: self.size)
        }
        let transition = SKTransition.fadeWithDuration(1.0)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view!.presentScene(secondScene, transition: transition)
    }
    
    private func addLabel(){
        let Titre = SKSpriteNode(imageNamed: "nomJeu.png")
        Titre.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (view?.bounds.height)!/2.5)
        //Titre.size = CGSize(width: 200, height: 50)
        Titre.zPosition = 2
        self.addChild(Titre)
    }

    
    private func addButtons() {
        // TODO layout buttons here
        let bouttonJouer = SKSpriteNode(imageNamed: "ButtonJouer.png")
        bouttonJouer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        bouttonJouer.name = "goToLevelScene"
        bouttonJouer.size = CGSize(width: 100, height: 50)
        bouttonJouer.zPosition = 2
        self.addChild(bouttonJouer)

    }
    

    
}