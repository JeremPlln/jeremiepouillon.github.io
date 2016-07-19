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
    var views = [UIView]()
    
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

        if (node.name == "BackToMenu") {
            removeEverythingFromView()
            let scene = MenuScene(size: self.size)
            let duration = 1.0
            let transition = SKTransition.fadeWithDuration(duration)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(scene, transition: transition)
        }
    }
    
    private func removeEverythingFromView(){
        for view in views {
            view.removeFromSuperview()
        }
        views.removeAll()
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
        Label(labelTitre, text: "FIN DE PARTIE!", offsetX: 0.0, offsetY: -(view?.bounds.height)!/2.2, alignment: true, adjustFont: false)
        Label(labelPhrase, text: "L'incendie a atteint la ville et a fait des victimes, vous avez failli à votre mission", offsetX: 0.0, offsetY: -(view?.bounds.height)!/2.8, alignment: true, adjustFont: true)
        Label(scoreVieLabel, text: String(format: "Nombre de vies sauvées : \(scoreVie)"), offsetX: 40.0, offsetY: -(view?.bounds.height)!/4.5, alignment: false)
        Label(scorePompierLabel, text: String(format: "Pompiers sollicités : \(scorePompier)"), offsetX: 40.0, offsetY: -(view?.bounds.height)!/7, alignment: false)
        Label(scoreCanadaireLabel, text: String(format: "Canadaires utilisés : \(scoreCanadaire)"), offsetX: 40.0, offsetY: -(view?.bounds.height)!/14, alignment: false)
        Label(scoreRetardantLabel, text: String(format: "Retardants utilisés : \(scoreRetardant)"), offsetX: 40.0, offsetY: 0.0, alignment: false)
        Label(scoreTotalLabel, text: String(format: "Total : \(scoreTotal)"), offsetX: 110.0, offsetY: (view?.bounds.height)!/6, alignment: false)
    }

    private func addButtons() {
        let backToMenu = SKSpriteNode(imageNamed: "ButtonMenuPrincipal.png")
        backToMenu.position = CGPointMake((view?.center.x)!, (view?.center.y)! - (view?.bounds.height)!/3)
        backToMenu.name = "BackToMenu"
        backToMenu.zPosition = 2
        backToMenu.size = CGSize(width: 75, height: 45)
        self.addChild(backToMenu)
    }
}