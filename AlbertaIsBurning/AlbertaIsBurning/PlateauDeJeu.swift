//
//  PlateauDeJeu.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 12/06/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import SpriteKit

class PlateauDeJeu {
    
    /* Notre plateau de jeu, chaque numéro correspond à une image */
    let tiles = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 2, 2, 9, 2, 11, 2, 10, 2, 9, 2, 2, 9, 10, 9, 2, 2, 9, 10, 2, 11, 1],
        [1, 2, 9, 2, 2, 2, 9, 2, 2, 10, 2, 9, 11, 9, 2, 2, 9, 10, 2, 2, 11, 1],
        [1, 10, 2, 9, 10, 2, 11, 2, 15, 14, 2, 2, 2, 10, 2, 2, 2, 2, 10, 15, 14, 1],
        [1, 2, 10, 2, 2, 11, 11, 2, 14, 2, 2, 2, 10, 2, 11, 2, 2, 3, 12, 13, 3, 1],
        [1, 9, 11, 2, 2, 2, 2, 14, 2, 2, 10, 2, 10, 2, 9, 2, 11, 12, 3, 14, 3, 1],
        [1, 9, 10, 2, 9, 2, 2, 10, 2, 10, 2, 9, 2, 2, 9, 3, 2, 9, 2, 2, 3, 1],
        [1, 2, 2, 11, 2, 10, 2, 2, 2, 9, 2, 2, 2, 9, 2, 2, 2, 2, 2, 11, 10, 1],
        [1, 2, 11, 2, 2, 2, 10, 2, 11, 11, 2, 2, 14, 2, 2, 10, 2, 2, 9, 2, 14, 1],
        [1, 11, 2, 10, 9, 2, 9, 2, 3, 12, 13, 13, 15, 2, 11, 3, 2, 10, 15, 16, 3, 1],
        [1, 2, 9, 11, 2, 2, 2, 11, 14, 16, 16, 15, 3, 2, 2, 11, 2, 14, 13, 12, 12, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
    
    /* les variables */
    var caseFire : [Int] = []
    var tempPositionCaseFire = [CGPoint]()
    var value : Int = 0
    var choixCase: Int = 0
    var coordonnees = [CGPoint]()
    var TableauFeu = [Case]()
    var COORD: [CGPoint] = []
    var departDeFeu = [Int]()
    
    init(){
        for i in 1..<tiles.count-1 { //on démarre à 1 car la 1ere valeur ne fait pas partie de la map
            let row = tiles[i]
            for j in 1..<row.count-1 {
                caseFire.append(value)
                TableauFeu.append(Case(id: value,image: tiles[i][j]))
                coordonnees.append(CGPoint(x: i-1, y: j-1))
                positionCaseFire.append(CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height))) //on note les coordonnées de la case
                value += 1
            }
        }
    }
    
    func getTiles() -> [[Int]]{
        return tiles
    }
    
    func getTableauFeu() -> [Case]{
        return TableauFeu
    }
    
    func getCase(id: Int) -> Case {
        return TableauFeu[id]
    }
    
    func getCoordonnees() -> [CGPoint]{
        return coordonnees
    }
    
    func setWind() -> Vent {
        let vent: Vent
        if let _vent = Vent.random() {
            vent = _vent
        }
        else {
            vent = .Est
        }

        return vent
    }
    
    func casePossible(vent: Vent) -> [Int]{
        var maCase: Case
        var tmp = [Int]()
        var foyerPossible = [Int]()
        for i in 0..<departDeFeu.count{
            tmp.removeAll()
            maCase = TableauFeu[departDeFeu[i]]
            switch vent {
            case .Est:
                if (maCase.colonne < nombreColonne-1){
                    tmp.append(departDeFeu[i]+1)
                    tmp.append(departDeFeu[i]+1-nombreColonne)
                    tmp.append(departDeFeu[i]+1+nombreColonne)
                }
                break
            case .SudEst:
                if (maCase.colonne < nombreColonne-1){
                    tmp.append(departDeFeu[i]+1)
                    tmp.append(departDeFeu[i]+1+nombreColonne)
                }
                tmp.append(departDeFeu[i]+nombreColonne)
                break
            case .Sud:
                tmp.append(departDeFeu[i]-1+nombreColonne)
                tmp.append(departDeFeu[i]+nombreColonne)
                tmp.append(departDeFeu[i]+1+nombreColonne)
                break
            case .SudOuest:
                if (maCase.colonne > 0){
                    tmp.append(departDeFeu[i]-1)
                    tmp.append(departDeFeu[i]-1+nombreColonne)
                }
                tmp.append(departDeFeu[i]+nombreColonne)
                break
            case .Ouest:
                if (maCase.colonne > 0){
                    tmp.append(departDeFeu[i]-1)
                    tmp.append(departDeFeu[i]-1-nombreColonne)
                    tmp.append(departDeFeu[i]-1+nombreColonne)
                }
                break
            case .NordOuest:
                if (maCase.colonne > 0){
                    tmp.append(departDeFeu[i]-1)
                    tmp.append(departDeFeu[i]-1-nombreColonne)
                }
                tmp.append(departDeFeu[i]-nombreColonne)
                break
            case .Nord:
                tmp.append(departDeFeu[i]+1-nombreColonne)
                tmp.append(departDeFeu[i]-1-nombreColonne)
                tmp.append(departDeFeu[i]-nombreColonne)
                break
            case .NordEst:
                if (maCase.colonne < nombreColonne-1){
                    tmp.append(departDeFeu[i]+1)
                    tmp.append(departDeFeu[i]+1-nombreColonne)
                }
                tmp.append(departDeFeu[i]-nombreColonne)
                break
            }
            
            for j in 0..<tmp.count{
                if (tmp[j] >= 0 && tmp[j] <= TableauFeu.count && TableauFeu[tmp[j]].estEnFeu == false && TableauFeu[tmp[j]].imageJeu != 6 && TableauFeu[tmp[j]].imageJeu != 8 && !foyerPossible.contains(tmp[j])) {
                    foyerPossible.append(tmp[j])
                }
            }
        }
        return foyerPossible
    }
}