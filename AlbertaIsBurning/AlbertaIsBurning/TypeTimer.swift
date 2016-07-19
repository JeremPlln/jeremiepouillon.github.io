//
//  TypeTimer.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/07/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation

enum TypeTimer: String {
    case generationTimerWind
    case generationTimerFire
    case generationTimerLife
    case generationTimeFoudre
    //        case timerDepart
    //        case lanceLaPause
    case retardantIncremente
    case retardantCanadaire
    case retardantPompier
    
    func period() -> NSTimeInterval {
        switch self {
        case .generationTimerWind:
            return 45
        case .generationTimerFire:
            return 7
        case .generationTimerLife:
            return 5
        case .generationTimeFoudre:
            return 15
        case .retardantIncremente:
            return 30
        case .retardantCanadaire:
            return 30
        case .retardantPompier:
            return 15
        }
    }
    
    func job(gameScene: GameScene) -> Timer.Job {
        switch self {
        case .generationTimerWind:
            return {
                gameScene.setWind()
            }
        case .generationTimerFire:
            return {
                gameScene.FirePropagation()
            }
        case .generationTimerLife:
            return {
                gameScene.decreaseLife()
            }
        case .generationTimeFoudre:
            return {
                gameScene.incendieFoudre()
            }
        case .retardantIncremente:
            return {
                compteurUniteRetardant += 1
            }
        case .retardantCanadaire:
            return {
                compteurUniteCanadaire += 1
            }
        case .retardantPompier:
            return {
                compteurUniteEau += 1
            }
        }
    }
}