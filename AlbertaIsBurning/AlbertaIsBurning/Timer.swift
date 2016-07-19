//
//  Timer.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/07/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation

class Timer {
    typealias Job = (() -> ())

    var stopped = false
    
    init(){

    }
    
    func registerJobWithType(type: TypeTimer, scene: GameScene) {
        registerJobWithFrequency(type.period(), job: type.job(scene))
    }
    
    func registerJobWithFrequency(seconds: NSTimeInterval, job: Job) {
        
        if stopped {
            return
        }
        
        doWithDelay(seconds) {
            job()
            self.registerJobWithFrequency(seconds, job: job)
        }

    }
    
    func doWithDelay(seconds: NSTimeInterval, job: Job) {
        
        if stopped {
            return
        }

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), job)
    }
    
    func stop() {
        stopped = true
    }
        
    
    
}