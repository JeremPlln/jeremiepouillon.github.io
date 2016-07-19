//
//  GameViewController.swift
//  Alberta
//
//  Created by Pouillon Jérémie on 17/05/2016.
//  Copyright (c) 2016 Pouillon Jérémie. All rights reserved.
//

import UIKit
import SpriteKit
import Social


class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = view as! SKView
        sceneView.ignoresSiblingOrder = true
        
        let myScene = MenuScene(size: view.bounds.size)
        myScene.scaleMode = .ResizeFill
        sceneView.presentScene(myScene)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.share), name: "test", object: nil)
    }
    
    func share(){
        let shareToFacebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("Je viens de jouer au Jeu Alberta is Burning et j'ai sauvé tous les habitants ! J'ai marqué \(scoreTotal) points, peux-tu faire mieux ?")
        self.presentViewController(shareToFacebook, animated: false, completion: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
