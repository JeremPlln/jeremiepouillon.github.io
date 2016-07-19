//
//  TypeJeu.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/07/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation

enum TypeJeu: String {
    case Cigarette
    case Foudre
    case Criminel
    
    func soundFilename() -> String {
        switch self {
        case .Cigarette:
            return "1"    /* Pour le mode cigarette */
        case .Foudre:
            return "2"    /* Pour le mode foudre */
        case .Criminel:
            return "3"    /* Pour le mode criminel */
        }
    }
    
    static func typeJeuForNode(node: String) -> TypeJeu? {
        let prefix = "BoutonMode"
        if node.hasPrefix(prefix) {
            if let rawValue = node.componentsSeparatedByString(prefix).last {
                return TypeJeu(rawValue: rawValue)
            }
        }
        
        return nil
    }
}
