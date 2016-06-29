//
//  Coordonnees.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/05/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Coordonnees {
    
    var abscisse : CGFloat = CGFloat()
    var ordonnee : CGFloat = CGFloat()
    var coord: CGPoint = CGPoint()
    
    init(x: CGFloat, y: CGFloat) {
        self.abscisse = x
        self.ordonnee = y
        self.coord.x = x
        self.coord.y = y
    }
    
    func displayCoordonnees(){
        print(abscisse,ordonnee)
    }
}