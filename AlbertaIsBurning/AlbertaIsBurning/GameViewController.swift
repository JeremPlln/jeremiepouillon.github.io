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
        // sceneView.showsFPS = true
        // sceneView.showsNodeCount = true
        sceneView.ignoresSiblingOrder = true
        
        let myScene = MenuScene(size: view.bounds.size)
        myScene.scaleMode = .ResizeFill
        sceneView.presentScene(myScene)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.share), name: "test", object: nil)
        
    }
    
    func shareFacebook() {
        let facebookSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
        
        facebookSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                //Add code to deal with it being cancelled
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: false, completion: nil)
                break
                
            case SLComposeViewControllerResult.Done:
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
                self.presentViewController(facebookSheet, animated: false, completion: nil)
                break
            }
        }
        
        facebookSheet.setInitialText("Test pour la démonstration du cours de serious game") //The default text in the tweet
        //facebookSheet.addImage(UIImage(named: "FondEcran.png")) //Add an image if you like?
        //facebookSheet.addURL(NSURL(string: "http://facebook.com")) //A url which takes you into safari if tapped on
        
        self.presentViewController(facebookSheet, animated: false, completion: {
            //Optional completion statement
        })
    }
    
    @IBAction func facebookButt(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let fb = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fb.setInitialText("I have collected \(scoreTotal) points!")
            fb.addImage(UIImage(named: "FondEcan.png"))
            viewController!.presentViewController(fb, animated: true, completion: nil)
            
        }else {
            let alert = UIAlertController(title: "Facebook",
                                          message: "Please login to your Facebook account in Settings",
                                          preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            viewController!.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    func share(){
        var shareToFacebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("Je viens de jouer au Jeu Alberta is Burning et j'ai sauvé tous les habitants ! J'ai marqué \(scoreTotal) points, peux-tu faire mieux ?")
        //shareToFacebook.addImage(UIImage(named:"FondEcran.png"))
        //shareToFacebook.addImage(UIImage(named: "FondEcran.png"))
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
