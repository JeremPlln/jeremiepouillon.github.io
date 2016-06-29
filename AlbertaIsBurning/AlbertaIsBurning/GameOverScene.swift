//
//  GameOverScene.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 10/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    let labelTitre = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    let labelPhrase = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 30))
    let scoreVieLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scorePompierLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scoreCanadaireLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scoreRetardantLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scoreTotalLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))

    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "gameOver.png")
        background.size.width = self.view!.bounds.width
        background.size.height = self.view!.bounds.height
        background.anchorPoint = CGPoint(x:0, y:0)
        self.addChild(background)
        
        addLabel()
        addButtons()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        // If next button is touched, start transition to second scene
        if (node.name == "BackToMenu") {
            removeEverythingFromView()
            let secondScene = MenuScene(size: self.size)
            let transition = SKTransition.flipVerticalWithDuration(1.0)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }
    }
    
    private func removeEverythingFromView(){
        labelTitre.removeFromSuperview()
        labelPhrase.removeFromSuperview()
        scoreVieLabel.removeFromSuperview()
        scoreTotalLabel.removeFromSuperview()
        scoreCanadaireLabel.removeFromSuperview()
        scoreRetardantLabel.removeFromSuperview()
        labelPhrase.removeFromSuperview()
        scorePompierLabel.removeFromSuperview()
    }
    
    private func addLabel(){
        labelTitre.center.x = (view?.center.x)!
        labelTitre.center.y = (view?.center.y)! - (view?.bounds.height)!/2.2
        labelTitre.textAlignment = NSTextAlignment.Center
        labelTitre.text = "FIN DE PARTIE!"
        labelTitre.textColor = UIColor.whiteColor()
        self.view?.addSubview(labelTitre)
        
        labelPhrase.center.x = (view?.center.x)!
        labelPhrase.center.y = (view?.center.y)! - (view?.bounds.height)!/2.8
        labelPhrase.textAlignment = NSTextAlignment.Center
        labelPhrase.text = "L'incendie a atteint la ville et a fait des victimes, vous avez failli à votre mission"
        labelPhrase.adjustsFontSizeToFitWidth = true
        labelPhrase.textColor = UIColor.whiteColor()
        self.view?.addSubview(labelPhrase)
        
        scoreVieLabel.center.x = (view?.center.x)! + 40
        scoreVieLabel.center.y = (view?.center.y)! - (view?.bounds.height)!/4.5
        scoreVieLabel.text = String(format: "Nombre de vies sauvées : \(scoreVie)")
        scoreVieLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(scoreVieLabel)

        scorePompierLabel.center.x = (view?.center.x)! + 40
        scorePompierLabel.center.y = (view?.center.y)! - (view?.bounds.height)!/7
        scorePompierLabel.text = String(format: "Pompiers sollicités : \(scorePompier)")
        labelPhrase.adjustsFontSizeToFitWidth = true
        scorePompierLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(scorePompierLabel)
 
        scoreCanadaireLabel.center.x = (view?.center.x)! + 40
        scoreCanadaireLabel.center.y = (view?.center.y)! - (view?.bounds.height)!/14
        scoreCanadaireLabel.text = String(format: "Canadaires utilisées : \(scoreCanadaire)")
        labelPhrase.adjustsFontSizeToFitWidth = true
        scoreCanadaireLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(scoreCanadaireLabel)

        scoreRetardantLabel.center.x = (view?.center.x)! + 40
        scoreRetardantLabel.center.y = (view?.center.y)!
        scoreRetardantLabel.text = String(format: "Retardants utilisés : \(scoreRetardant)")
        labelPhrase.adjustsFontSizeToFitWidth = true
        scoreRetardantLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(scoreRetardantLabel)

        scoreTotalLabel.center.x = (view?.center.x)! + 110
        scoreTotalLabel.center.y = (view?.center.y)! + (view?.bounds.height)!/6
        scoreTotalLabel.text = String(format: "Total : \(scoreTotal)")
        labelPhrase.adjustsFontSizeToFitWidth = true
        scoreTotalLabel.textColor = UIColor.whiteColor()
        self.view?.addSubview(scoreTotalLabel)
 
    }

    private func addButtons() {
        // TODO layout buttons here
        let backToMenu = SKSpriteNode(imageNamed: "ButtonMenuPrincipal.png")
        backToMenu.position = CGPointMake((view?.center.x)!, (view?.center.y)! - (view?.bounds.height)!/3)
        backToMenu.name = "BackToMenu"
        backToMenu.zPosition = 2
        backToMenu.size = CGSize(width: 75, height: 45)
        self.addChild(backToMenu)
    }
}