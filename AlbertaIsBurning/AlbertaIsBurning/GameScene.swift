//
//  GameScene.swift
//  AlbertaIsDying
//
//  Created by Pouillon Jérémie on 15/05/2016.
//  Copyright (c) 2016 Pouillon Jérémie. All rights reserved.
//

import SpriteKit
import AVFoundation

enum Tile: Int {
    
    case Ground
    case Wall
    case Arbre1
    case Building1
    case Fire
    case Avion
    case Eau
    case Canadaire
    case Retardant
    case Arbre2
    case Arbre3
    case Arbre4
    case Building2
    case Building3
    case Building4
    case Building5
    case Building6
    
    var description:String {
        switch self {
        case Ground:
            return "Ground"
        case Wall:
            return "Wall"
        case Arbre1:
            return "Arbre1"
        case Building1:
            return "Building1"
        case Fire:
            return "Fire"
        case Avion:
            return "Avion"
        case Eau:
            return "Eau"
        case Canadaire:
            return "Canadaire"
        case Retardant:
            return "Retardant"
        case Arbre2:
            return "Arbre2"
        case Arbre3:
            return "Arbre3"
        case Arbre4:
            return "Arbre4"
        case Building2:
            return "Building2"
        case Building3:
            return "Building3"
        case Building4:
            return "Building4"
        case Building5:
            return "Building5"
        case Building6:
            return "Building6"
        }
    }
    
    var image:SKSpriteNode {
        switch self {
        case Ground:
            let ground = SKSpriteNode(imageNamed: "sol")
            ground.name = kSpriteTouchable
            return ground
        case Wall:
            let wall = SKSpriteNode(imageNamed: "wall")
            wall.name = kSpriteNotTouchable
            return wall
        case Arbre1:
            let arbre = SKSpriteNode(imageNamed: "arbre1")
            arbre.name = kSpriteTouchable
            return arbre
        case Building1:
            let maison = SKSpriteNode(imageNamed: "building1")
            maison.name = kSpriteNotTouchable
            return maison
        case Fire:
            let feu = SKSpriteNode(imageNamed: "feu")
            feu.name = kSpriteNotTouchable
            return feu
        case Avion:
            let avion = SKSpriteNode(imageNamed: "Avion")
            return avion
        case Eau:
            let water = SKSpriteNode(imageNamed: "eau")
            water.name = kSpriteTouchable
            return water
        case Canadaire:
            let icon = SKSpriteNode(imageNamed: "icon2")
            return icon
        case Retardant:
            let ret = SKSpriteNode(imageNamed: "icon3")
            return ret
        case Arbre2:
            let arbre = SKSpriteNode(imageNamed: "arbre2")
            arbre.name = kSpriteTouchable
            return arbre
        case Arbre3:
            let arbre = SKSpriteNode(imageNamed: "arbre3")
            arbre.name = kSpriteTouchable
            return arbre
        case Arbre4:
            let arbre = SKSpriteNode(imageNamed: "arbre4")
            arbre.name = kSpriteTouchable
            return arbre
        case Building2:
            let maison = SKSpriteNode(imageNamed: "building2")
            maison.name = kSpriteNotTouchable
            return maison
        case Building3:
            let maison = SKSpriteNode(imageNamed: "building3")
            maison.name = kSpriteNotTouchable
            return maison
        case Building4:
            let maison = SKSpriteNode(imageNamed: "building4")
            maison.name = kSpriteNotTouchable
            return maison
        case Building5:
            let maison = SKSpriteNode(imageNamed: "building5")
            maison.name = kSpriteNotTouchable
            return maison
        case Building6:
            let maison = SKSpriteNode(imageNamed: "building6")
            maison.name = kSpriteNotTouchable
            return maison
        }
    }
}

enum Vent: Int{
    case Est
    case SudEst
    case Sud
    case SudOuest
    case Ouest
    case NordOuest
    case Nord
    case NordEst
    
    var IMAGE: UIImage{
        switch self {
        case Est:
            let tmp = UIImage(named: "vent_1.png")
            return tmp!
        case SudEst:
            let tmp = UIImage(named: "vent_8.png")
            return tmp!
        case Sud:
            let tmp = UIImage(named: "vent_7.png")
            return tmp!
        case SudOuest:
            let tmp = UIImage(named: "vent_6.png")
            return tmp!
        case Ouest:
            let tmp = UIImage(named: "vent_5.png")
            return tmp!
        case NordOuest:
            let tmp = UIImage(named: "vent_4.png")
            return tmp!
        case Nord:
            let tmp = UIImage(named: "vent_3.png")
            return tmp!
        case NordEst:
            let tmp = UIImage(named: "vent_2.png")
            return tmp!
        }
    }
}

class GameScene: SKScene {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = UILabel()
    let canadaireMark = SKSpriteNode()
    let retardantMark = SKSpriteNode()
    
    var toolbar: UIToolbar = UIToolbar()
    var ImageVent : UIImageView = UIImageView()
    var vent = Vent(rawValue: 0)
    var ImageEau: UIImageView = UIImageView()
    var water: UIImage = UIImage(named: "icon1.png")!
    var ImageCanadaire: UIImageView = UIImageView()
    var canadaire: UIImage = UIImage(named: "icon2.png")!
    
    var ImageRetardant: UIImageView = UIImageView()
    var retardant: UIImage = UIImage(named: "icon3.png")!
    
    var unitePompier: UITextView = UITextView()
    var uniteCanadaire: UITextView = UITextView()
    var uniteRetardant: UITextView = UITextView()
    
    var ImageVie: UIImageView = UIImageView()
    var life: UIImage = UIImage(named: "vie")!
    var vieTxt: UITextView = UITextView()
    
    var pigeIndex = Int()
    var count: Int = 0
    var bool: Bool = false
    var generationTimerWind: NSTimer!
    var generationTimerFire: NSTimer!
    var generationTimerLife: NSTimer!
    var generationTimeFoudre: NSTimer!
    var debuteLaGame: NSTimer!
    var timerDepart: NSTimer!
    var lanceLaPause: NSTimer!
    var rechargeRetardant: NSTimer!
    var textLu = false
    var fond = UIImageView()
    let background = UIImage(named: "fondOpaque.png")
    var txtSerieux = UITextView()
    let okay = UIButton()
    
    var ligne: Int = 0
    var colonne: Int = 0
    var secondPartie = false
    var TextureAtlas = SKTextureAtlas()
    var TextureArrayHero = [SKTexture]()
    var feuPose = false
    var introductionFinie = false
    var choixCase = Int()
    var audioPlayerEclair = AVAudioPlayer()
    var audioPlayerCigarette = AVAudioPlayer()
    var audioPlayerFoudre = AVAudioPlayer()
    var audioPlayerCriminel = AVAudioPlayer()
    var timerFinIntroduction = NSDate()
    var retardantIncremente: NSTimer!
    var retardantCanadaire: NSTimer!
    var retardantPompier: NSTimer!
    
    init(size: CGSize, typeJeu: Int) {
        view2D = SKSpriteNode()
        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        newPlateau.typePartie = typeJeu
    }
    
    override func didMoveToView(view: SKView) {
        start()
        putGameInPause(1)
        afficherTexte()
        
        switch newPlateau.typePartie {
        case 1:
            introductionCigarette()
        case 2:
            introductionFoudre()
        case 3:
            introductionCriminel()
        default:
            break
        }
        
        retardantIncremente = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(GameScene.rechargeUniteRetardant), userInfo: nil, repeats: true)
        
        retardantCanadaire = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(GameScene.rechargeUniteCanadaire), userInfo: nil, repeats: true)

        retardantPompier = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(GameScene.rechargeUnitePompier), userInfo: nil, repeats: true)
        
    }
    
    func afficherTexte(){
        fond.image = UIImage(named: "fondOpaque\(newPlateau.typePartie).png")
        fond.frame = CGRect(x: 0, y: 0, width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        view?.addSubview(fond)
    }
    
    func pause(){
        view?.paused = true
    }
    
    func introductionCigarette(){
        let introductionSound = NSBundle.mainBundle().pathForResource("1", ofType: "mp3")
        if let introductionSound = introductionSound {
            let myFilePathURL = NSURL(fileURLWithPath: introductionSound)
            
            do{
                try audioPlayerCigarette = AVAudioPlayer(contentsOfURL: myFilePathURL)
                //audioPlayerCanadaire.prepareToPlay()
                audioPlayerCigarette.play()
            }catch
            {
                print("ERROR")
            }
            
            audioPlayerCigarette.delegate?.audioPlayerDidFinishPlaying!(audioPlayerCigarette, successfully: true)
        }
    }
    
    func introductionFoudre(){
        let introductionSound = NSBundle.mainBundle().pathForResource("2", ofType: "mp3")
        if let introductionSound = introductionSound {
            let myFilePathURL = NSURL(fileURLWithPath: introductionSound)
            
            do{
                try audioPlayerFoudre = AVAudioPlayer(contentsOfURL: myFilePathURL)
                //audioPlayerCanadaire.prepareToPlay()
                audioPlayerFoudre.play()
            }catch
            {
                print("ERROR")
            }
        }
    }
    
    func introductionCriminel(){
        let introductionSound = NSBundle.mainBundle().pathForResource("3", ofType: "mp3")
        if let introductionSound = introductionSound {
            let myFilePathURL = NSURL(fileURLWithPath: introductionSound)
            
            do{
                try audioPlayerCriminel = AVAudioPlayer(contentsOfURL: myFilePathURL)
                //audioPlayerCanadaire.prepareToPlay()
                audioPlayerCriminel.play()
            }catch
            {
                print("ERROR")
            }
        }
    }
    
    func setWind() -> Int{
        ImageVent.removeFromSuperview()
        vent = Vent(rawValue: newPlateau.setWind())
        ImageVent.image = vent?.IMAGE
        ImageVent.frame = CGRect(x: 43, y: 6, width: 20, height: 20)
        view?.addSubview(ImageVent)
        return newPlateau.setWind()
    }
    
    func creationPremierFOyer(seconds: NSTimeInterval){
        timerDepart = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.DepartFeu), userInfo: nil, repeats: false)
    }
    
    
    func putGameInPause(seconds: NSTimeInterval){
        lanceLaPause = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.pause), userInfo: nil, repeats: false)
    }
    
    func changeWindOrientation(seconds: NSTimeInterval){
        generationTimerWind = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.setWind), userInfo: nil, repeats: true)
    }
    
    func propagationDuFeu(seconds: NSTimeInterval){
        generationTimerFire = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.FirePropagation), userInfo: nil, repeats: true)
    }
    
    func viesSauvees(seconds: NSTimeInterval){
        generationTimerLife = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.decreaseLife), userInfo: nil, repeats: true)
    }
    
    func genereNouveauDepartDeFeu(seconds: NSTimeInterval){
        generationTimeFoudre = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.incendieFoudre), userInfo: nil, repeats: true)
    }
    
    func startIncendieMode1Et3(seconds:NSTimeInterval){
        debuteLaGame = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: #selector(GameScene.incendieFoudre), userInfo: nil, repeats: false)
    }
    
    func rechargeUniteRetardant(){
        compteurUniteRetardant += 1
    }
    
    func rechargeUniteCanadaire(){
        compteurUniteCanadaire += 1
    }
    
    func rechargeUnitePompier(){
        compteurUniteEau += 1
    }
    
    func setToolbar(){
        //initialisation de la toolbar en haut de l'écran
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view!.frame.size.width, height: 10)
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.blackColor()
        self.view?.addSubview(toolbar)
        
        ImageCanadaire.image = canadaire
        ImageCanadaire.frame = CGRect(x: 233, y: 6, width: 23, height: 23)
        self.view!.addSubview(ImageCanadaire)
        
        uniteCanadaire = UITextView(frame: CGRect(x: 207, y: 2, width: 30, height: 20))
        uniteCanadaire.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(uniteCanadaire)
        
        ImageRetardant.image = retardant
        ImageRetardant.frame = CGRect(x: 315, y: 6, width: 23, height: 23)
        self.view!.addSubview(ImageRetardant)
        
        uniteRetardant = UITextView(frame: CGRect(x: 289, y: 2, width: 30, height: 20))
        uniteRetardant.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(uniteRetardant)
        
        ImageEau.image = water
        ImageEau.frame = CGRect(x: 151, y: 6, width: 23, height: 23)
        self.view!.addSubview(ImageEau)
        
        unitePompier = UITextView(frame: CGRect(x: 125, y: 2, width: 30, height: 20))
        unitePompier.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(unitePompier)
        
        ImageVie.image = life
        ImageVie.frame = CGRect(x: 450.5, y: 6, width: 23, height: 23)
        self.view!.addSubview(ImageVie)
        
        vieTxt = UITextView(frame: CGRect(x: 405, y: 2, width: 50, height: 20))
        vieTxt.backgroundColor = UIColor.clearColor()
        self.view!.addSubview(vieTxt)
    }
    
    func decreaseLife(){
        compteurUniteVie -= Int(arc4random_uniform(UInt32(200))+1)
    }
    
    func DepartFeu() {
        switch newPlateau.typePartie {
        case 1:
            incendieFoudre()
        case 2:
            genereNouveauDepartDeFeu(10)
        case 3:
            incendieCriminel()
        default:
            print("ERROR")
        }
    }
    
    func incendieFoudre(){
        //let choixCase: Int
        choixCase = Int(arc4random_uniform(UInt32(newPlateau.TableauFeu.count)))
        //choixCase = 142
        if (newPlateau.getCase(choixCase).imageJeu == 3 || newPlateau.getCase(choixCase).imageJeu == 12 || newPlateau.getCase(choixCase).imageJeu == 13 || newPlateau.getCase(choixCase).imageJeu == 14 || newPlateau.getCase(choixCase).imageJeu == 15 || newPlateau.getCase(choixCase).imageJeu == 16){
            gameIsRunning = false
            isGameOver = true
            gameOver()
        }

        newPlateau.getCase(choixCase).estEnFeu = true
        newPlateau.departDeFeu.append(choixCase)
        let coordonneesEcran = positionCaseFire[choixCase]
        //let feu = SKSpriteNode(imageNamed: "feu")
        var fire = SKSpriteNode()
        let TextureAtlas = SKTextureAtlas(named: "fire")
        var TextureArray = [SKTexture]()
        
        //boucle d'animation de la fusee
        for i in 1..<4{
            let Name = "gif\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
        }
        
        fire = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
        fire.size = CGSize(width: 32, height: 32)
        fire.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.1)))
        
        fire.name = kSpriteNotTouchable
        fire.position = coordonneesEcran
        fire.anchorPoint = CGPoint(x:0, y:0)
        fire.zPosition = 2
        view2D.addChild(fire)
        feuPose = true
        if (newPlateau.typePartie == 2){
            let eclairSound = NSBundle.mainBundle().pathForResource("eclair", ofType: "mp3")
            if let eclairSound = eclairSound {
                let myFilePathURL = NSURL(fileURLWithPath: eclairSound)
                
                do{
                    try audioPlayerEclair = AVAudioPlayer(contentsOfURL: myFilePathURL)
                    audioPlayerEclair.play()
                }catch
                {
                    print("ERROR")
                }
            }
        }
    }
    
    func setFumee(id : Int, orientation: Int){
        newPlateau.getCase(id).estEnFeu = true
        newPlateau.departDeFeu.append(id)
        let coordonneesEcran = positionCaseFire[id]
        var fumee = SKSpriteNode()
        var TextureAtlas = SKTextureAtlas()
        var TextureArray = [SKTexture]()
        
        switch orientation {
        case 0:
            TextureAtlas = SKTextureAtlas(named: "fumeeEst")
            break
        case 1:
            TextureAtlas = SKTextureAtlas(named: "fumeeSudEst")
            break
        case 2:
            TextureAtlas = SKTextureAtlas(named: "fumeeSud")
            break
        case 3:
            TextureAtlas = SKTextureAtlas(named: "fumeeSudOuest")
            break
        case 4:
            TextureAtlas = SKTextureAtlas(named: "fumeeOuest")
            break
        case 5:
            TextureAtlas = SKTextureAtlas(named: "fumeeNordOuest")
            break
        case 6:
            TextureAtlas = SKTextureAtlas(named: "fumeeNord")
            break
        case 7:
            TextureAtlas = SKTextureAtlas(named: "fumeeNordEst")
            break
        default:
            break
        }
        
        //boucle d'animation du feu
        for i in 0..<11{
            let Name = "fumee\(i).png"
            TextureArray.append(TextureAtlas.textureNamed(Name))
        }
        fumee = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
        //fumee.size = CGSize(width: 32, height: )
        fumee.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.1)))
        fumee.size = CGSize(width: 55, height: 55)
        fumee.name = kSpriteNotTouchable
        fumee.position = coordonneesEcran
        fumee.anchorPoint = CGPoint(x:0, y:0)
        fumee.zPosition = 2
        fumee.alpha = 0.6
        view2D.addChild(fumee)
        
    }
    
    func incendieCriminel(){
        for i in 0..<3 {
            //choixCase = Int(arc4random_uniform(UInt32(newPlateau.TableauFeu.count)))
            if(i == 0) {choixCase = 142}
            if(i == 1) {choixCase = 22}
            if(i == 2) {choixCase = 90}
            newPlateau.getCase(choixCase).estEnFeu = true
            newPlateau.departDeFeu.append(choixCase)
            let coordonneesEcran = positionCaseFire[choixCase]
            // let feu = SKSpriteNode(imageNamed: "feu")
            var fire = SKSpriteNode()
            let TextureAtlas = SKTextureAtlas(named: "fire")
            var TextureArray = [SKTexture]()
            
            //boucle d'animation de la fusee
            for i in 1..<4{
                let Name = "gif\(i).png"
                TextureArray.append(SKTexture(imageNamed: Name))
            }
            fire = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
            fire.size = CGSize(width: 32, height: 32)
            fire.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.1)))
            
            fire.name = kSpriteNotTouchable
            fire.position = coordonneesEcran
            fire.anchorPoint = CGPoint(x:0, y:0)
            fire.zPosition = 2
            view2D.addChild(fire)
            feuPose = true
            /*
             feu.name = kSpriteNotTouchable
             feu.position = coordonneesEcran
             feu.anchorPoint = CGPoint(x:0, y:0)
             view2D.addChild(feu)
             */
            //setFumee(choixCase, orientation: newPlateau.setWind())
        }
    }
    
    func GetNumeroCase(row: Int, col: Int, tableau: [CGPoint]) -> Int{
        var indice: Int = 0
        for i in 0..<tableau.count{
            if(Int(tableau[i].x) != row){
                indice += 1
            }
            else if (Int(tableau[i].y) != col){
                indice += 1
            }
            else {
                return indice
            }
        }
        return 0
    }
    
    
    func FirePropagation(){
        let mesCases = newPlateau.casePossible()
        
        if(mesCases.count > 0){
            let caseChoisie = newPlateau.getCase(mesCases[Int(arc4random_uniform(UInt32(mesCases.count)))])
            if (caseChoisie.imageJeu == 3 || caseChoisie.imageJeu == 12 || caseChoisie.imageJeu == 13 || caseChoisie.imageJeu == 14 || caseChoisie.imageJeu == 15 || caseChoisie.imageJeu == 16){
                gameIsRunning = false
                isGameOver = true
                gameOver()
            }
                
            else{
                newPlateau.departDeFeu.append(caseChoisie.id)
                caseChoisie.estEnFeu = true
                
                var fire = SKSpriteNode()
                let TextureAtlas = SKTextureAtlas(named: "fire")
                var TextureArray = [SKTexture]()
                
                //boucle d'animation de la fusee
                for i in 1..<4{
                    let Name = "gif\(i).png"
                    TextureArray.append(SKTexture(imageNamed: Name))
                }
                fire = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
                fire.size = CGSize(width: 32, height: 32)
                fire.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.1)))
                fire.name = kSpriteNotTouchable
                fire.position = positionCaseFire[caseChoisie.id]
                fire.anchorPoint = CGPoint(x: 0,y: 0)
                fire.zPosition = 2
                choixCase = caseChoisie.id
                view2D.addChild(fire)
                feuPose = true
                //setFumee(caseChoisie.id, orientation: newPlateau.setWind())
            }
        }
    }
    
    func placeTile2D(image:SKSpriteNode, withPosition:CGPoint) {
        //let tileSprite = SKSpriteNode(imageNamed: image)
        let tileSprite = image
        tileSprite.position = withPosition
        tileSprite.anchorPoint = CGPoint(x:0, y:0)
        view2D.addChild(tileSprite)
    }
    
    func placeAllTiles2D() {
        for i in 0..<newPlateau.getTiles().count {
            for j in 0..<newPlateau.getTiles()[i].count{
                
                let tileInt = newPlateau.getTiles()[i][j]
                let tile = Tile(rawValue: tileInt)!
                let point = CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height))
                placeTile2D(tile.image, withPosition:point)
            }
        }
    }
    
    func gameIsWin(){
        if newPlateau.typePartie == 2 {
            generationTimeFoudre.invalidate()
            generationTimeFoudre = nil
        }
        isGameOver = false
        gameIsRunning = false
        stop()
        generationTimerWind.invalidate()
        generationTimerFire.invalidate()
        generationTimerLife.invalidate()
        if(newPlateau.typePartie == 1 || newPlateau.typePartie == 3) {
            timerDepart.invalidate()
            timerDepart = nil
        }
        retardantCanadaire.invalidate()
        retardantPompier.invalidate()
        retardantIncremente.invalidate()
        generationTimerWind = nil
        generationTimerFire = nil
        generationTimerLife = nil
        retardantIncremente = nil
        retardantCanadaire = nil
        retardantPompier = nil
        let goToWinnerScene = WinnerScene(size: self.size)
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        goToWinnerScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(goToWinnerScene, transition: transition)
    }
    
    func gameOver(){
        if newPlateau.typePartie == 2 {
            generationTimeFoudre.invalidate()
            generationTimeFoudre = nil
        }
        isGameOver = false
        gameIsRunning = false
        stop()
        generationTimerWind.invalidate()
        generationTimerFire.invalidate()
        generationTimerLife.invalidate()
        if(newPlateau.typePartie == 1 || newPlateau.typePartie == 3) {
            timerDepart.invalidate()
            timerDepart = nil
        }
        retardantCanadaire.invalidate()
        retardantPompier.invalidate()
        retardantIncremente.invalidate()
        generationTimerWind = nil
        generationTimerFire = nil
        generationTimerLife = nil
        retardantIncremente = nil
        retardantCanadaire = nil
        retardantPompier = nil
        let goToGameOverScene = GameOverScene(size: self.size)
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        goToGameOverScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(goToGameOverScene, transition: transition)
    }
    
    func stop(){
        toolbar.removeFromSuperview()
        ImageCanadaire.removeFromSuperview()
        ImageRetardant.removeFromSuperview()
        ImageVent.removeFromSuperview()
        ImageVie.removeFromSuperview()
        uniteRetardant.removeFromSuperview()
        uniteCanadaire.removeFromSuperview()
        unitePompier.removeFromSuperview()
        vieTxt.removeFromSuperview()
        ImageEau.removeFromSuperview()
        if(newPlateau.typePartie == 2){audioPlayerEclair.stop()}
        
        //positionCaseFire.removeAll()
        //onScene.removeAll()
        view?.removeGestureRecognizer(toucheCase)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if (view?.paused == true){
            view?.paused = false
            generationTimerWind = NSTimer()
            generationTimerFire = NSTimer()
            generationTimerLife = NSTimer()
            generationTimeFoudre = NSTimer()
            debuteLaGame = NSTimer()
            timerDepart = NSTimer()
            propagationDuFeu(7)
            changeWindOrientation(20)
            viesSauvees(5)
            if(newPlateau.typePartie == 1 || newPlateau.typePartie == 3) {creationPremierFOyer(2)}
            if(newPlateau.typePartie == 2) {
               genereNouveauDepartDeFeu(15)
            }
            fond.removeFromSuperview()
        }
        else {
            for touch: AnyObject in touches
            {
                let locationNode = touch.locationInNode(self)
                let NodeAtPoint = self.nodeAtPoint(locationNode)
                
                if (NodeAtPoint.name == kSpriteTouchable){
                    kCASE_SELECTIONNEE = GetNumeroCase(Int(NodeAtPoint.position.x), col: Int(NodeAtPoint.position.y), tableau: positionCaseFire)
                    kLIGNE = newPlateau.getCase(kCASE_SELECTIONNEE).ligne
                    kCOLONNE = newPlateau.getCase(kCASE_SELECTIONNEE).colonne
                    showMenu(toucheCase)
                }
            }
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if(gameIsRunning){
            
            
            unitePompier.text = String(compteurUniteEau)
            self.view!.addSubview(unitePompier)
            
            uniteCanadaire.text = String(compteurUniteCanadaire)
            self.view!.addSubview(uniteCanadaire)
            
            uniteRetardant.text = String(compteurUniteRetardant)
            self.view!.addSubview(uniteRetardant)
            
            vieTxt.text = String(compteurUniteVie)
            self.view!.addSubview(vieTxt)
            
            scoreVie = (compteurUniteVieDepart - compteurUniteVie)
            scorePompier = pompierUse
            scoreCanadaire = canadaireUse
            scoreRetardant = retardantUse
            scoreTotal = scoreVie + scoreRetardant + scoreCanadaire + scorePompier
            
            if compteurUniteVie < 0 {gameIsWin()}
        }
        /*
         if(feuPose) {
         setFumee(choixCase, orientation: newPlateau.setWind())
         feuPose = false
         }
         */
    }
    
    func generateButtons() -> [ALRadialMenuButton] {
        var buttons = [ALRadialMenuButton]()
        
        for i in 0..<3 {
            let button = ALRadialMenuButton(frame: CGRectMake(0, 0, 30, 30))
            button.setImage(UIImage(named: "icon\(i+1)"), forState: UIControlState.Normal)
            buttons.append(button)
        }
        buttons[1].accessibilityIdentifier = "Canadaire"
        buttons[2].accessibilityIdentifier = "Retardant"
        return buttons
    }
    
    func showMenu(sender: UITapGestureRecognizer) {
        abscisse = sender.locationInView(view).x
        ordonnee = sender.locationInView(view).y
        ALRadialMenu(view: view!)
            .setButtons(generateButtons())
            .setDelay(0.05)
            .setAnimationOrigin(sender.locationInView(view))
            .presentInView(view!)
    }
    
    func start() {
        lanceLaPause = NSTimer()
        
        view?.addGestureRecognizer(toucheCase)
        compteurUniteVie = compteurUniteVieDepart
        compteurUniteRetardant = compteurUniteCRetardantDepart
        compteurUniteCanadaire = compteurUniteCanadaireDepart
        compteurUniteEau = compteurUniteEauDepart
        
        let deviceScale = self.size.width/667
        view2D.position = CGPoint(x:-self.size.width*0.528, y:self.size.height*0.373) //0.465
        
        view2D.xScale = deviceScale
        view2D.yScale = deviceScale
        addChild(view2D)
        
        placeAllTiles2D()
        setToolbar()
        setWind()
    }
}

