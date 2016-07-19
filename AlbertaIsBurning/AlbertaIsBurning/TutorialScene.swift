//
//  TutorialScene.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 10/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    
    var tutoriel = UIImageView()
    var derniereImage = false
    var deuxiemeImage = false
    var troisiemeImage = false
    var quatriemeImage = false
    
    override func didMoveToView(view: SKView) {
        
        tutoriel.image = UIImage(named: "tutoriel1")
        tutoriel.frame = CGRect(x: 0, y: 0, width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        view.addSubview(tutoriel)
        deuxiemeImage = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (derniereImage == true) {
            initTutoriel("tutoriel5")
            
            let secondScene = LevelScene(size: self.size)
            let transition = SKTransition.fadeWithDuration(1.0)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view!.presentScene(secondScene, transition: transition)
            tutoriel.removeFromSuperview()
            derniereImage = false
        }
        else if (deuxiemeImage == true){
            troisiemeImage = true
            initTutoriel("tutoriel2")
            deuxiemeImage = false
        }
        else if (troisiemeImage == true){
            quatriemeImage = true
            initTutoriel("tutoriel5")
            troisiemeImage = false
        }
        else if (quatriemeImage == true){
            derniereImage = true
            initTutoriel("tutoriel4")
            quatriemeImage = false
        }
    }
    
    func initTutoriel(fileName: String){
        tutoriel.removeFromSuperview()
        tutoriel.image = UIImage(named: fileName)
        tutoriel.frame = CGRect(x: 0, y: 0, width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        view?.addSubview(tutoriel)
    }
}