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
    var views = [UIView]()
    
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
        
        let scene = MenuScene(size: self.size)
        
        if node.name == "goToMenuScene" {
            removeEverythingFromView()
            let duration = 1.0
            let transition = SKTransition.fadeWithDuration(duration)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(scene, transition: transition)
        }
        else {
            NSNotificationCenter.defaultCenter().postNotificationName("test", object: nil)
        }
    }
    
    private func addLabel(){
        
        func Label(label: UILabel, text: String, offsetX: CGFloat, offsetY: CGFloat, alignment: Bool = true, adjustFont: Bool = true){
            label.center.x = (view?.center.x)! + offsetX
            label.center.y = (view?.center.y)! + offsetY
            if alignment {label.textAlignment = NSTextAlignment.Center}
            if adjustFont {label.adjustsFontSizeToFitWidth = true}
            label.text = text
            label.textColor = UIColor.whiteColor()
            views.append(label)
            for view in views {
                self.view?.addSubview(view)
            }
        }
        Label(labelTitre, text: "PARTIE GAGNEE!", offsetX: 0.0, offsetY: -(view?.bounds.height)!/2.2, alignment: true, adjustFont: false)
        Label(labelPhrase, text: "Vous avez maitrisé l'incendie, tout les habitants ont pû être évacués !", offsetX: 0.0, offsetY: -(view?.bounds.height)!/2.8, alignment: true, adjustFont: true)
        Label(scoreVieLabel, text: String(format: "Nombre de vies sauvées : \(scoreVie)"), offsetX: 40.0, offsetY: -(view?.bounds.height)!/4.5, alignment: false)
        Label(scorePompierLabel, text: String(format: "Pompiers sollicités : \(scorePompier)"), offsetX: 40.0, offsetY: -(view?.bounds.height)!/7, alignment: false)
        Label(scoreCanadaireLabel, text: String(format: "Canadaires utilisés : \(scoreCanadaire)"), offsetX: 40.0, offsetY: -(view?.bounds.height)!/14, alignment: false)
        Label(scoreRetardantLabel, text: String(format: "Retardants utilisés : \(scoreRetardant)"), offsetX: 40.0, offsetY: 0.0, alignment: false)
        Label(scoreTotalLabel, text: String(format: "Total : \(scoreTotal)"), offsetX: 110.0, offsetY: (view?.bounds.height)!/6, alignment: false)
        Label(partageScore, text: String(format: "Partage ton score : "), offsetX: 30.0, offsetY: (view?.bounds.height)!/3.5, alignment: false)
    }
    
    private func addButtons() {
        // TODO layout buttons here
        func button(nameFile: String, nameNode: String?, offsetX: CGFloat, offsetY: CGFloat, size: Bool = false) {
            let button = SKSpriteNode(imageNamed: nameFile)
            button.position = CGPointMake(CGRectGetMidX(self.frame)+offsetX, CGRectGetMidY(self.frame) + offsetY)
            button.size = CGSize(width: 32, height: 32)
            if size {button.size = CGSize(width: 75, height: 45)}
            button.name = nameNode
            button.zPosition = 2
            self.addChild(button)
            
        }
        button("facebook.png", nameNode: "BoutonFacebook", offsetX: 50.0, offsetY: -(view?.bounds.height)!/3.5)
        button("twitter.png", nameNode: "BoutonTwitter", offsetX: 90.0, offsetY: -(view?.bounds.height)!/3.5)
        button("ButtonMenuPrincipal", nameNode: "goToMenuScene", offsetX: 0.0, offsetY: -(view?.bounds.height)!/2.4, size: true)
    }
    
    private func removeEverythingFromView(){
        for view in views {
            view.removeFromSuperview()
        }
        views.removeAll()
    }
}