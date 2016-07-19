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
        
        let scene: SKScene
        if let nodeName = node.name, let typeJeu = TypeJeu.typeJeuForNode(nodeName) {
            gameIsRunning = true
            
            scene = GameScene(size: self.size, typeJeu: typeJeu)
        }
        else {
            scene = TutorialScene(size: self.size)
            
        }
        
        let duration = 1.0
        let transition = SKTransition.fadeWithDuration(duration)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view!.presentScene(scene, transition: transition)
        

    }
    
    private func addButtons() {
        // TODO layout buttons here
        func Button(nameFile: String, nameNode: String?, offset: CGFloat, size: Bool = true){
            let button = SKSpriteNode(imageNamed: nameFile)
            button.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + offset)
            button.name = nameNode
            button.zPosition = 2
            if size {button.size = CGSize(width: 100.0, height: 50.0)}
            self.addChild(button)
        }
        
        Button("nomJeu.png", nameNode: nil, offset: (view?.bounds.height)!/2.5, size: false)
        Button("BouttonTutoriel.png", nameNode: "BoutonModeTutoriel", offset: 55)
        Button("BouttonCigaretteMode.png", nameNode: "BoutonModeCigarette", offset: 0)
        Button("BouttonFoudre.png", nameNode: "BoutonModeFoudre", offset: -55)
        Button("BouttonCriminel.png",nameNode: "BoutonModeCriminel", offset: -110)
    }
}