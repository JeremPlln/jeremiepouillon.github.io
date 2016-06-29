//
//  ALRadialMenu.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 24/05/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation


private typealias ALAnimationsClosure = () -> Void

struct Angle {
    var degrees: Double
    
    
    func radians() -> Double {
        return degrees * (M_PI/180)
    }
}

public class ALRadialMenu: UIButton {
    // MARK: Public API
    
    var selectedIndex = Int()
    var myView = UIView()
    var audioPlayerPompier = AVAudioPlayer()
    var audioPlayerCanadaire = AVAudioPlayer()
    var timerSon: NSTimeInterval = 5.0

    public convenience init(view: UIView) {
        self.init(frame: CGRectZero, view: view)
    }
    
    public init(frame: CGRect, view: UIView) {
        self.myView = view
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /**
     Set a delay to stagger the showing of each subsequent radial button
     
     Note: this is a bit buggy when using UIView animations
     
     Default = 0
     
     - parameter Double: The delay in seconds
     */
    public func setDelay(delay: Double) -> Self {
        self.delay = delay
        return self
    }
    
    /**
     Set the buttons to display when present is called. Each button should be an instance of ALRadialMenuButton
     
     - parameter Array: An array of ALRadialMenuButton instances
     */
    public func setButtons(buttons: [ALRadialMenuButton]) -> Self {
        self.buttons = buttons
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let action = button.action
            
            button.center = myView.center
            button.action = {
                self._dismiss(i)
                if let a = action {
                    a()
                }
            }
        }
        return self
    }
    
    /**
     Set to false to disable dismissing the menu on background tap
     
     Default = true
     
     - parameter Bool: enabled or disable the gesture
     */
    public func setDismissOnOverlayTap(dismissOnOverlayTap: Bool) -> Self {
        self.dismissOnOverlayTap = dismissOnOverlayTap
        return self
    }
    
    /**
     Set the radius to control how far from the point of origin the buttons should show when the menu is open
     
     Default = 100
     
     - parameter Double: the radius in pts
     */
    public func setRadius(radius: Double) -> Self {
        self.radius = radius
        return self
    }
    
    /**
     Set the starting angle from which to lay out the buttons
     
     Default = 270
     
     - parameter Double: the angle in degrees
     */
    public func setStartAngle(degrees: Double) -> Self {
        self.startAngle = Angle(degrees: degrees)
        return self
    }
    
    /**
     Set the total circumference that the buttons should be laid out in
     
     Default = 360
     
     - parameter Double: the circumference in degrees
     */
    public func setCircumference(degrees: Double) -> Self {
        self.circumference = Angle(degrees: degrees)
        return self
    }
    
    /**
     Set the origin point from which the buttons should animate
     
     Default = self.center
     
     - parameter CGPoint: the origin point
     */
    public func setAnimationOrigin(animationOrigin: CGPoint) -> Self {
        self.animationOrigin = animationOrigin
        return self
    }
    
    /**
     Present the buttons in the specified view's window
     
     - parameter UIView: view
     */
    public func presentInView(view: UIView) -> Self {
        return presentInWindow(view.window!)
    }
    
    /**
     Present the buttons in the specified window
     
     - parameter UIWindow: window
     */
    public func presentInWindow(win: UIWindow) -> Self {
        
        if buttons.count == 0 {
            print("ALRadialMenu has no buttons to present")
            return self
        }
        
        if animationOrigin == nil {
            animationOrigin = myView.center
        }
        
        win.addSubview(overlayView)
        
        for i in 0..<buttons.count {
            
            let button = buttons[i]
            win.addSubview(button)
            presentAnimation(button, index: i)
        }
        return self
    }
    
    /**
     Dismiss the buttons with an animation
     */
    public func dismiss() {
        
        if buttons.count == 0 {
            print("ALRadialMenu has no buttons to dismiss")
            return
        }
        
        _dismiss(-1)
    }
    
    // MARK: private vars
    private var delay: Double = 0
    private var buttons = [ALRadialMenuButton]() {
        didSet {
            calculateSpacing()
        }
    }
    
    private var dismissOnOverlayTap = true {
        didSet {
            if let gesture = dismissGesture {
                gesture.enabled = dismissOnOverlayTap
            }
        }
    }
    
    private var overlayView = UIView(frame: UIScreen.mainScreen().bounds)
    private var radius: Double = 35
    private var startAngle: Angle = Angle(degrees: 270)
    private var circumference: Angle = Angle(degrees: 360) {
        didSet {
            calculateSpacing()
        }
    }
    
    private var spacingDegrees: Angle!
    private var animationOrigin: CGPoint!
    private var dismissGesture: UITapGestureRecognizer!
    private var animationOptions: UIViewAnimationOptions = [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.BeginFromCurrentState]
    
    // MARK: Private API
    private func commonInit() {
        dismissGesture = UITapGestureRecognizer(target: self, action: #selector(ALRadialMenu.dismiss))
        dismissGesture.enabled = dismissOnOverlayTap
        overlayView.addGestureRecognizer(dismissGesture)
    }
    
    private func _dismiss(selectedIndex: Int) {
        overlayView.removeFromSuperview()
        
        for i in 0..<buttons.count {
            if i == selectedIndex {
                if(buttons[i].accessibilityIdentifier == "Canadaire") {
                    showMenuCanadaire()
                }
                else if (buttons[i].accessibilityIdentifier == "choixCanadaire\(i)"){
                    if(compteurUniteCanadaire>0) {
                        placeEau(i)
                        let canadaireSound = NSBundle.mainBundle().pathForResource("canadaire", ofType: "mp3")
                        if let canadaireSound = canadaireSound {
                            let myFilePathURL = NSURL(fileURLWithPath: canadaireSound)
                            
                            do{
                                try audioPlayerCanadaire = AVAudioPlayer(contentsOfURL: myFilePathURL)
                                //audioPlayerCanadaire.prepareToPlay()
                                audioPlayerCanadaire.play()
                            }catch
                            {
                                print("ERROR")
                            }
                        }
                    }
                }
                else if (buttons[i].accessibilityIdentifier == "Retardant"){
                    showMenuRetardant()
                }
                else if (buttons[i].accessibilityIdentifier == "choixRetardant\(i)"){
                    if(compteurUniteRetardant>0){
                        placeRetardant(i)
                        let canadaireSound = NSBundle.mainBundle().pathForResource("canadaire", ofType: "mp3")
                        if let canadaireSound = canadaireSound {
                            let myFilePathURL = NSURL(fileURLWithPath: canadaireSound)
                            
                            do{
                                try audioPlayerCanadaire = AVAudioPlayer(contentsOfURL: myFilePathURL)
                                //audioPlayerCanadaire.prepareToPlay()
                                audioPlayerCanadaire.volume = 1.0
                                audioPlayerCanadaire.play()
                            }catch
                            {
                                print("ERROR")
                            }
                        }
                    }
                }
                else{
                    placePompier(i)
                    //let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("camionpompier", ofType: "wav")!)
                    
                    let pompierSound = NSBundle.mainBundle().pathForResource("camionpompier", ofType: "mp3")
                    if let pompierSound = pompierSound {
                        let myFilePathURL = NSURL(fileURLWithPath: pompierSound)
                        
                        do{
                            try audioPlayerPompier = AVAudioPlayer(contentsOfURL: myFilePathURL)
                            //audioPlayerPompier.prepareToPlay()
                            audioPlayerPompier.volume = 1.0
                            audioPlayerPompier.play()
                        }catch
                        {
                            print("ERROR")
                        }
                    }
                    
                    selectedAnimation(buttons[i])
                }
                dismissAnimation(buttons[i], index: i)
            }
            else {
                dismissAnimation(buttons[i], index: i)
            }
        }
    }
    
    func setView(view: UIImageView, hidden: Bool) {
        UIImageView.transitionWithView(view, duration: 0.5, options: .TransitionCrossDissolve, animations: {() -> Void in
            view.hidden = hidden
            }, completion: { _ in })
    }
    
    func placePompier(indice: Int){
        let eau = SKSpriteNode(imageNamed: "eau")
        eau.position = positionCaseFire[kCASE_SELECTIONNEE]
        newPlateau.getCase(kCASE_SELECTIONNEE).estEnFeu = false
        eau.anchorPoint = CGPoint(x:0, y:0)
        eau.runAction(SKAction.fadeAlphaTo(0.0, duration: 15))
        view2D.addChild(eau)
        if (eau.alpha == 0.0){eau.hidden = false}
        compteurUniteEau -= 1
        pompierUse += 1
    }
    
    func placeEau(indice: Int){
        var dossierImage = [SKSpriteNode]()
        var caseID = Int()
        for _ in 0..<3{
            dossierImage.append(SKSpriteNode(imageNamed: "eau"))
        }
        
        for j in -1..<dossierImage.count-1{
            switch indice {
            case 0:
                caseID = kCASE_SELECTIONNEE + j*nombreColonne
                break
            case 1:
                caseID = kCASE_SELECTIONNEE + j*(nombreColonne+1)
                break
            case 2:
                caseID = kCASE_SELECTIONNEE + j
                break
            case 3:
                caseID = kCASE_SELECTIONNEE + j*(nombreColonne-1)
                break
            default:
                break
            }
            
            if (caseID >= 0 && caseID <= newPlateau.getTableauFeu().count && newPlateau.getCase(caseID).estEnFeu == false && (compteurUniteCanadaire>0 || compteurUniteEau>0) && newPlateau.getCase(caseID).imageJeu != 3 && newPlateau.getCase(caseID).imageJeu != 12 && newPlateau.getCase(caseID).imageJeu != 13 && newPlateau.getCase(caseID).imageJeu != 14 && newPlateau.getCase(caseID).imageJeu != 15 && newPlateau.getCase(caseID).imageJeu != 16){
                dossierImage[j+1].position = positionCaseFire[caseID]
                newPlateau.getCase(caseID).estEnFeu = false
                newPlateau.getCase(caseID).imageJeu = 6
                dossierImage[j+1].anchorPoint = CGPoint(x:0, y:0)
                view2D.addChild(dossierImage[j+1])
                dossierImage[j+1].runAction(SKAction.fadeAlphaTo(0.0, duration: 30))
            }
        }
        compteurUniteCanadaire -= 1
        canadaireUse += 1
        selectedAnimation(buttons[indice])
    }
    
    func placeRetardant(indice: Int){
        var dossierImage = [SKSpriteNode]()
        var caseID = Int()
        for _ in 0..<3{
            dossierImage.append(SKSpriteNode(imageNamed: "retardant"))
        }
        
        for j in -1..<dossierImage.count-1{
            switch indice {
            case 0:
                caseID = kCASE_SELECTIONNEE + j*nombreColonne
                break
            case 1:
                caseID = kCASE_SELECTIONNEE + j*(nombreColonne+1)
                break
            case 2:
                caseID = kCASE_SELECTIONNEE + j
                break
            case 3:
                caseID = kCASE_SELECTIONNEE + j*(nombreColonne-1)
                break
            default:
                break
            }
            
            if (caseID >= 0 && caseID <= newPlateau.getTableauFeu().count && newPlateau.getCase(caseID).estEnFeu == false && compteurUniteRetardant>0){
                dossierImage[j+1].position = positionCaseFire[caseID]
                newPlateau.getCase(caseID).estEnFeu = false
                newPlateau.getCase(caseID).imageJeu = 8
                dossierImage[j+1].anchorPoint = CGPoint(x:0, y:0)
                view2D.addChild(dossierImage[j+1])
                dossierImage[j+1].runAction(SKAction.fadeAlphaTo(0.0, duration: 60))
            }
        }
        compteurUniteRetardant -= 1
        retardantUse += 1
        selectedAnimation(buttons[indice])
    }
    
    private func presentAnimation(view: ALRadialMenuButton, index: Int) {
        let degrees = startAngle.degrees + spacingDegrees.degrees * Double(index)
        let newCenter = pointOnCircumference(animationOrigin, radius: radius, angle: Angle(degrees: degrees), ligne: kLIGNE, col: kCOLONNE)
        let _delay = Double(index) * delay
        view.center = animationOrigin
        view.alpha = 0
        UIView.animateWithDuration(0.5, delay: _delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: animationOptions, animations: {
            view.alpha = 1
            view.center = newCenter
            }, completion: nil)
    }
    
    private func dismissAnimation(view: ALRadialMenuButton, index: Int) {
        let _delay = Double(index) * delay
        UIView.animateWithDuration(0.5, delay: _delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: animationOptions, animations: {
            view.alpha = 0
            view.center = self.animationOrigin
            }, completion: { finished in
                view.removeFromSuperview()
        })
    }
    
    private func selectedAnimation(view: ALRadialMenuButton) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: animationOptions, animations: {
            view.alpha = 0
            view.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: { finished in
                view.transform = CGAffineTransformIdentity
                view.removeFromSuperview()
        })
    }
    
    private func pointOnCircumference(origin: CGPoint, radius: Double, angle: Angle, ligne: Int, col: Int) -> CGPoint {
        let radians = angle.radians()
        let x = origin.x + CGFloat(radius) * CGFloat(cos(radians))
        let y = origin.y + CGFloat(radius) * CGFloat(sin(radians))
        return CGPointMake(x, y)
        
    }
    
    private func calculateSpacing() -> Angle {
        if buttons.count > 0 {
            var c = buttons.count
            
            if circumference.degrees < 360 {
                c -= 1
            }
            if (kLIGNE == 0 && kCOLONNE == 0){
                radius = 38
                startAngle.degrees = 0
                spacingDegrees = Angle(degrees: 45)
                return spacingDegrees
            }
            else if (kLIGNE == 0 && kCOLONNE > 0 && kCOLONNE < nombreColonne - 1){
                radius = 32
                startAngle.degrees = 0
                spacingDegrees = Angle(degrees: 90)
                return spacingDegrees
            }
            else if (kLIGNE == 0 && kCOLONNE == nombreColonne-1){
                radius = 38
                startAngle.degrees = 90
                spacingDegrees = Angle(degrees: 45)
                return spacingDegrees
            }
            else if (kLIGNE>0 && kLIGNE < nombreLigne - 1 && kCOLONNE == nombreColonne - 1){
                radius = 32
                startAngle.degrees = 90
                spacingDegrees = Angle(degrees: 90)
                return spacingDegrees
            }
            else if (kLIGNE == nombreLigne - 1 && kCOLONNE == nombreColonne - 1){
                radius = 38
                startAngle.degrees = 180
                spacingDegrees = Angle(degrees: 45)
                return spacingDegrees
            }
            else if (kLIGNE == nombreLigne - 1 && kCOLONNE > 0 && kCOLONNE < nombreColonne - 1){
                radius = 32
                startAngle.degrees = 180
                spacingDegrees = Angle(degrees: 90)
                return spacingDegrees
            }
            else if (kLIGNE == nombreLigne - 1 && kCOLONNE == 0){
                radius = 38
                startAngle.degrees = 270
                spacingDegrees = Angle(degrees: 45)
                return spacingDegrees
            }
            else if (kLIGNE>0 && kLIGNE < nombreLigne - 1 && kCOLONNE == 0){
                radius = 32
                startAngle.degrees = 270
                spacingDegrees = Angle(degrees: 90)
                return spacingDegrees
            }
            else{
                radius = 32
                startAngle.degrees = 270
                spacingDegrees = Angle(degrees: circumference.degrees / Double(c))
                return spacingDegrees
            }
        }
        else {
            return Angle(degrees: 0)
        }
    }
    func generateButtonsCanadaire() -> [ALRadialMenuButton] {
        
        var buttonsCanadaire = [ALRadialMenuButton]()
        
        for i in 3..<7 {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 30, 30))
            button.setImage(UIImage(named: "icon\(i+1)"), forState: UIControlState.Normal)
            buttonsCanadaire.append(button)
            buttonsCanadaire[i-3].accessibilityIdentifier = "choixCanadaire\(i-3)"
        }
        return buttonsCanadaire
    }
    
    func generateButtonsRetardant() -> [ALRadialMenuButton] {
        var buttonsRetardant = [ALRadialMenuButton]()
        
        for i in 7..<11 {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 30, 30))
            button.setImage(UIImage(named: "icon\(i+1)"), forState: UIControlState.Normal)
            buttonsRetardant.append(button)
            buttonsRetardant[i-7].accessibilityIdentifier = "choixRetardant\(i-7)"
        }
        return buttonsRetardant
    }
    
    func showMenuCanadaire() {
        ALRadialMenu(view: myView)
            .setButtons(generateButtonsCanadaire())
            .setDelay(0.05)
            .setAnimationOrigin(CGPoint(x: abscisse, y: ordonnee))
            .presentInView(myView)
    }
    
    func showMenuRetardant() {
        ALRadialMenu(view: myView)
            .setButtons(generateButtonsRetardant())
            .setDelay(0.05)
            .setAnimationOrigin(CGPoint(x: abscisse, y: ordonnee))
            .presentInView(myView)
    }
    
}
