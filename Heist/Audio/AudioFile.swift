//
//  AudioFile.swift
//  Heist2
//
//  Created by rjm on 20/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation
import AudioKit
import AudioKitUI
import Cocoa

class AudioFile {
    let trackedAmplitude : AKAmplitudeTracker
    let player : AKPlayer
    let file : AKAudioFile

    static let sharedAudio = AudioFile()
    
    init() {
        file = try! AKAudioFile(readFileName: "TennisCourt.wav")
        player = AKPlayer(audioFile: file)
        trackedAmplitude = AKAmplitudeTracker(player)
    }
    
    func playFile() {
        player.isLooping = true
        AudioKit.output = trackedAmplitude
        try! AudioKit.start()
        player.play()
    }
    
    func stopFile() {
        player.stop()
    }
    
    func next() {
        print(trackedAmplitude.amplitude)
    }
    
    func getAmp() -> Double {
        return  trackedAmplitude.amplitude
    }
}

