//
//  Vent.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/07/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import UIKit

enum Vent: Int {
    case Est
    case SudEst
    case Sud
    case SudOuest
    case Ouest
    case NordOuest
    case Nord
    case NordEst
    
    static func random() -> Vent? {
        return Vent(rawValue: Int(arc4random_uniform(UInt32(8))))
    }
    
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
