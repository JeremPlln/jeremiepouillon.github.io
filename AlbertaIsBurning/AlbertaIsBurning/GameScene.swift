//
//  GameScene.swift
//  AlbertaIsDying
//
//  Created by Pouillon Jérémie on 15/05/2016.
//  Copyright (c) 2016 Pouillon Jérémie. All rights reserved.
//

import SpriteKit
import AVFoundation


class GameScene: SKScene {

    var viewsAdded = false
    
    /////////////////VARIABLES LIEES A LA TOOLBAR//////////////////
    var toolbar: UIToolbar = UIToolbar()
    var ImageVent : UIImageView = UIImageView()
    var vent: Vent?
    
    var ImageEau: UIImageView = UIImageView()
    var water: UIImage = UIImage(named: "icon1.png")!
    
    var views = [UIView]()
    
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
    
    let timer = Timer()
    
    var fond = UIImageView()
    let background = UIImage(named: "fondOpaque.png")
    
    var ligne: Int = 0
    var colonne: Int = 0
    var TextureAtlas = SKTextureAtlas()
    var TextureArrayHero = [SKTexture]()
    var feuPose = false
    var choixCase = Int()
    var typePartie: TypeJeu
    
    /////////////////VARIABLES SON//////////////////
    let audioPlayerEclair = AudioPlayer(soundName: "eclair")
    let audioPlayer: AudioPlayer?
    
    init(size: CGSize, typeJeu: TypeJeu) {
        self.typePartie = typeJeu
        self.audioPlayer = AudioPlayer(soundName: typeJeu.soundFilename())
        view2D = SKSpriteNode()
        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///// ON AFFICHE UN TEXT POUR DIRE AU JOUEUR CE QUI L'ATTEND DANS LE MODE DE JEU QU'IL A CHOISI /////
    func afficherTexte(){
        fond.image = UIImage(named: "fondOpaque\(typePartie).png")
        fond.frame = CGRect(x: 0, y: 0, width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        view?.addSubview(fond)
    }
    
    func pause(){
        view?.paused = true
    }

    //////// FONCTION QUI INITIALISE UNE DIRECTION DU VENT AU DEBUT DE LA PARTIE ////////
    func setWind() {
        ImageVent.removeFromSuperview()
        vent = newPlateau.setWind()
        ImageVent.image = vent?.IMAGE
        ImageVent.frame = CGRect(x: 43, y: 6, width: 20, height: 20)
        views.append(ImageVent)
        self.view?.addSubview(ImageVent)
    }
    
    ///////// FONCTION QUI ORGANISE LA TOOLBAR ////////
    func setToolbar(){
        /* initialisation de la toolbar en haut de l'écran */
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view!.frame.size.width, height: 10)
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.blackColor()
        views.append(toolbar)
        
        /* initialisation des icones de la toolbar */
        /* Pour le canadaire */
        ImageCanadaire.image = canadaire
        ImageCanadaire.frame = CGRect(x: 233, y: 6, width: 23, height: 23)
        views.append(ImageCanadaire)
        
        uniteCanadaire = UITextView(frame: CGRect(x: 207, y: 2, width: 30, height: 20))
        uniteCanadaire.backgroundColor = UIColor.clearColor()
        views.append(uniteCanadaire)
        
        /* Pour le retardant */
        ImageRetardant.image = retardant
        ImageRetardant.frame = CGRect(x: 315, y: 6, width: 23, height: 23)
        views.append(ImageRetardant)
        
        uniteRetardant = UITextView(frame: CGRect(x: 289, y: 2, width: 30, height: 20))
        uniteRetardant.backgroundColor = UIColor.clearColor()
        views.append(uniteRetardant)
        
        /* Pour les pompiers */
        ImageEau.image = water
        ImageEau.frame = CGRect(x: 151, y: 6, width: 23, height: 23)
        views.append(ImageEau)
        
        unitePompier = UITextView(frame: CGRect(x: 125, y: 2, width: 30, height: 20))
        unitePompier.backgroundColor = UIColor.clearColor()
        views.append(unitePompier)
        
        /* Pour le nombre de vie à évacuer */
        ImageVie.image = life
        ImageVie.frame = CGRect(x: 450.5, y: 6, width: 23, height: 23)
        views.append(ImageVie)
        
        vieTxt = UITextView(frame: CGRect(x: 405, y: 2, width: 50, height: 20))
        vieTxt.backgroundColor = UIColor.clearColor()
        views.append(vieTxt)
        
        for view in views {
            self.view?.addSubview(view)
        }
    }
    
    ///////// FONCTION QUI DIMINUE LE NOMBRE DE VIES RESTANTES A EVACUER DE FACON ALEATOIRE ////////
    func decreaseLife(){
        compteurUniteVie -= Int(arc4random_uniform(UInt32(200))+1)
    }
    
    //////////// SELON LE MODE DE JEU CHOISI ON APPELLE LA BONNE FONCTION //////////
    func DepartFeu() {
        switch typePartie {
        case .Cigarette:
            incendieFoudre()
        case .Criminel:
            incendieCriminel()
        default:
            return
        }
    }
    
    func setupPlateau() {
        newPlateau.getCase(choixCase).estEnFeu = true /* case sur le plateau prend feu : elle passe a true */
        newPlateau.departDeFeu.append(choixCase) /* on ajoute cette case à notre tableau de depart de feu */
        let coordonneesEcran = positionCaseFire[choixCase] /* on recupere les coordonnees de la case */
        
        /* On va charger ici les images pour l'animation du feu */
        var fire = SKSpriteNode()
        let TextureAtlas = SKTextureAtlas(named: "fire")
        var TextureArray = [SKTexture]()
        
        /* boucle d'animation du feu */
        for i in 1..<4{
            let Name = "gif\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
        }
        
        fire = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
        fire.size = CGSize(width: 32, height: 32)
        fire.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.1)))
        
        fire.name = kSpriteNotTouchable /* on ne veut pas que le joueur puisse éteindre le feu directement */
        fire.position = coordonneesEcran
        fire.anchorPoint = CGPoint(x:0, y:0)
        fire.zPosition = 2
        view2D.addChild(fire)
        
        feuPose = true
    }
    
    ///////// FONCTION POUR LE MODE FOUDRE : CHOIX D'UNE CASE QUI VA BRULER + CHARGE LES ANIMATIONS /////////
    /////////////////////// DE FEU ET LES PLACE AU BON ENDROIT SUR NOTRE PLATEAU DE JEU /////////////////////
    func incendieFoudre(){
        /* une case au hasard est pigée pour démarrer un foyer */
        choixCase = Int(arc4random_uniform(UInt32(newPlateau.TableauFeu.count)))
        
        /* Si cette case touche un batiment, le jeu est perdu */
        //// NOTE A MOI MEME : C'EST UN PEU SEVERE ////
        if (newPlateau.getCase(choixCase).imageJeu == 3 || newPlateau.getCase(choixCase).imageJeu == 12 || newPlateau.getCase(choixCase).imageJeu == 13 || newPlateau.getCase(choixCase).imageJeu == 14 || newPlateau.getCase(choixCase).imageJeu == 15 || newPlateau.getCase(choixCase).imageJeu == 16){
            gameIsRunning = false
            isGameOver = true
            gameOver()
        }
        
        setupPlateau()
        
        /* On joue un son d'éclair lorsque unnouveau foyer démarre */
        if (typePartie == .Foudre){
            audioPlayerEclair?.playSound()
        }
    }
    
    ///////// FONCTION POUR LE MODE CRIMINEL : DEPART DE FEU MULTIPLE (CHOIX DE 3 CASES DIFFERENTES) ///////
    func incendieCriminel(){
        /* pour chaque case choisie, on la décor avec l'animation de feu et on la place sur le plateau */
        for i in 0..<3 {
            //choixCase = Int(arc4random_uniform(UInt32(newPlateau.TableauFeu.count)))
            if(i == 0) {choixCase = 142}
            if(i == 1) {choixCase = 22}
            if(i == 2) {choixCase = 90}
            
            setupPlateau()
        }
    }
    
    ///////////// FONCTION POUR FACILITER LA CORRESPONDANCE ENTRE LE NUMERO DE LA CASE ET /////////////
    /////////////                   SES COORDONNEES SUR LE PLATEAU DE JEU                  /////////////
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
    
    ///////// FONCTION QUI GERE LA PROPAGATION DU FEU A PARTIR D'UN FOYER /////////
    func FirePropagation(){
        guard let v = vent else {
            print("Pas de vent = pas de propagation")
            return
        }
        var mesCases = newPlateau.casePossible(v)
        
        if(mesCases.count > 0){
            let caseChoisie = newPlateau.getCase(mesCases[Int(arc4random_uniform(UInt32(mesCases.count)))])
            /* Si la nouvelle case qui prend feu touche un batiment quelconque du plateau de jeu: c'est perdu */
            if (caseChoisie.imageJeu == 3 || caseChoisie.imageJeu == 12 || caseChoisie.imageJeu == 13 || caseChoisie.imageJeu == 14 || caseChoisie.imageJeu == 15 || caseChoisie.imageJeu == 16){
                gameIsRunning = false
                isGameOver = true
                gameOver()
            }
                /* Sinon le feu continue de propager */
            else{
                newPlateau.departDeFeu.append(caseChoisie.id)
                caseChoisie.estEnFeu = true
                
                var fire = SKSpriteNode()
                let TextureAtlas = SKTextureAtlas(named: "fire")
                var TextureArray = [SKTexture]()
                
                /* boucle d'animation du feu */
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
    
    //////// FONCTIONS QUI CREER NOTRE PLATEAU DE JEU : MET BOUT A BOUT DES CASES CARREES ///////
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
    
    ////////// FONCTIONS QUI STOPENT LE JEU LORSQUE LE JOUEUR GAGNE OU PERD LA PARTIE /////////////
    
    /* lorsqu'il gagne */
    func gameIsWin(){
        stop()
        let goToWinnerScene = WinnerScene(size: self.size)
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        goToWinnerScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(goToWinnerScene, transition: transition)
    }
    
    /* lorsqu'il perd */
    func gameOver(){
        stop()
        let goToGameOverScene = GameOverScene(size: self.size)
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        goToGameOverScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(goToGameOverScene, transition: transition)
    }
    
    func stop(){
        isGameOver = false
        gameIsRunning = false
        newPlateau.departDeFeu.removeAll()
        timer.stop()
        for view in views {
            view.removeFromSuperview()
        }
        views.removeAll()
        if (typePartie == .Foudre) {
            audioPlayerEclair?.stop()
        }
        view?.removeGestureRecognizer(toucheCase)
    }
    
    
    // GAME SETUP
    override func didMoveToView(view: SKView) {
        start()
        
        timer.doWithDelay(1) {
            self.pause()
        }
        
        afficherTexte()
        
        audioPlayer?.playSound()
    }
    
    // GAME SETUP
    func start() {
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

    private func scheduleTimer() {
        var types = [TypeTimer]()
        types.append(.generationTimerWind)
        types.append(.generationTimerFire)
        types.append(.generationTimerLife)
        types.append(.generationTimerWind)
        types.append(.retardantIncremente)
        types.append(.retardantCanadaire)
        types.append(.retardantPompier)
        
        if(typePartie == .Foudre) {
            types.append(.generationTimeFoudre)
        }
        
        for type in types {
            timer.registerJobWithType(type, scene: self)
        }
        
        timer.doWithDelay(2) {
            self.DepartFeu()
        }
    }
    
    //////////// FONCTIONS OVERRIDE ////////////
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if (view?.paused == true){
            // GAME SETUP
            view?.paused = false
 
            scheduleTimer()

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
                    ALRadialMenu.showMenu(toucheCase)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        /* on met à jour pendant le jeu, les variables/compteurs */
        if(gameIsRunning){
            
            unitePompier.text = String(compteurUniteEau)
            uniteCanadaire.text = String(compteurUniteCanadaire)
            uniteRetardant.text = String(compteurUniteRetardant)
            vieTxt.text = String(compteurUniteVie)

            if viewsAdded == false {
                self.view!.addSubview(unitePompier)
                self.view!.addSubview(uniteCanadaire)
                self.view!.addSubview(uniteRetardant)
                self.view!.addSubview(vieTxt)
                viewsAdded = true
            }
            scoreVie = (compteurUniteVieDepart - compteurUniteVie)
            scorePompier = pompierUse
            scoreCanadaire = canadaireUse
            scoreRetardant = retardantUse
            scoreTotal = scoreVie + scoreRetardant + scoreCanadaire + scorePompier
            
            if compteurUniteVie < 0 {gameIsWin()}
        }
    }
}