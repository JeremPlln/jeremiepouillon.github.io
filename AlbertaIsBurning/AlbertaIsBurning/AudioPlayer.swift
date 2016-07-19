//
//  AudioPlayer.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 19/07/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import Foundation
import AVFoundation

struct AudioPlayer {
    let audioPlayer: AVAudioPlayer
    
    init?(soundName: String) {
        if let sound = NSBundle.mainBundle().pathForResource(soundName, ofType: "mp3") {
            let myFilePathURL = NSURL(fileURLWithPath: sound)
            do{
                self.audioPlayer = try AVAudioPlayer(contentsOfURL: myFilePathURL)
            }catch
            {
                print("ERROR")
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func playSound() {
        audioPlayer.play()
    }
    
    func stop() {
        audioPlayer.stop()
    }
}