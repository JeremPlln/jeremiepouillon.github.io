//
//  WinnerScene.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 10/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit
import Social
import UIKit

class WinnerScene: SKScene{
    
    let labelTitre = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    let labelPhrase = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 30))
    let scoreVieLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scorePompierLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scoreCanadaireLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scoreRetardantLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let scoreTotalLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let partageScore = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))

    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "winnerBackground.png")
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
        
        let secondScene = MenuScene(size: self.size)
        
        switch node.name {
        case "BoutonFacebook"? :
            NSNotificationCenter.defaultCenter().postNotificationName("test", object: nil)

            //secondScene = GameScene(size: self.size, typeJeu: 1)
            //        case "BoutonTwitter"? :
        //secondScene = GameScene(size: self.size, typeJeu: 2)
        case "goToMenuScene"? :
            removeEverythingFromView()
            let transition = SKTransition.flipVerticalWithDuration(1.0)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(secondScene, transition: transition)
        default:
            break
        }
    }
    
    private func addLabel(){
        labelTitre.center.x = (view?.center.x)!
        labelTitre.center.y = (view?.center.y)! - (view?.bounds.height)!/2.2
        labelTitre.textAlignment = NSTextAlignment.Center
        labelTitre.text = "PARTIE GAGNEE!"
        labelTitre.textColor = UIColor.whiteColor()
        self.view?.addSubview(labelTitre)
        
        labelPhrase.center.x = (view?.center.x)!
        labelPhrase.center.y = (view?.center.y)! - (view?.bounds.height)!/2.8
        labelPhrase.textAlignment = NSTextAlignment.Center
        labelPhrase.text = "Vous avez maitrisé l'incendie, tout les habitants ont pû être évacués !"
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
        
        partageScore.center.x = (view?.center.x)!+30
        partageScore.center.y = (view?.center.y)! + (view?.bounds.height)!/3.5
        partageScore.text = String(format: "Partage ton score : ")
        partageScore.adjustsFontSizeToFitWidth = true
        partageScore.textColor = UIColor.whiteColor()
        self.view?.addSubview(partageScore)
    }
    
    private func addButtons() {
        // TODO layout buttons here
        let facebookButton = SKSpriteNode(imageNamed: "facebook.png")
        facebookButton.position = CGPointMake(CGRectGetMidX(self.frame)+50, CGRectGetMidY(self.frame) - (view?.bounds.height)!/3.5)
        facebookButton.size = CGSize(width: 32, height: 32)
        facebookButton.name = "BoutonFacebook"
        facebookButton.zPosition = 2
        self.addChild(facebookButton)
        
        let twitterButton = SKSpriteNode(imageNamed: "twitter.png")
        twitterButton.position = CGPointMake(CGRectGetMidX(self.frame)+90, CGRectGetMidY(self.frame) - (view?.bounds.height)!/3.5)
        twitterButton.size = CGSize(width: 32, height: 32)
        twitterButton.name = "BoutonTwitter"
        twitterButton.zPosition = 2
        self.addChild(twitterButton)
        
        let menuButton = SKSpriteNode(imageNamed: "ButtonMenuPrincipal")
        menuButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (view?.bounds.height)!/2.4)
        menuButton.name = "goToMenuScene"
        menuButton.zPosition = 2
        menuButton.size = CGSize(width: 75, height: 45)
        self.addChild(menuButton)
    }
    
    private func removeEverythingFromView(){
        labelTitre.removeFromSuperview()
        labelPhrase.removeFromSuperview()
        partageScore.removeFromSuperview()
        scoreTotalLabel.removeFromSuperview()
        scoreVieLabel.removeFromSuperview()
        scoreRetardantLabel.removeFromSuperview()
        scoreCanadaireLabel.removeFromSuperview()
        scorePompierLabel.removeFromSuperview()
    }

    private func shareTwitter(){
        
    }
    
}