//
//  AudioIn.swift
//  Heist2
//
//  Created by rjm on 17/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation
import AudioKit
import AudioKitUI
import Cocoa

class AudioIn {
    let oscillatorNode : AKOperationGenerator
    let trackedAmplitude : AKAmplitudeTracker

    init() {
        oscillatorNode = AKOperationGenerator { _ in
            let volume = AKOperation.sineWave(frequency: 0.2).scale(minimum: 0, maximum: 0.5)
            let frequency = AKOperation.jitter(amplitude: 200, minimumFrequency: 10, maximumFrequency: 30) + 200
            return AKOperation.sineWave(frequency: frequency, amplitude: volume)
        }
        trackedAmplitude = AKAmplitudeTracker(oscillatorNode)
        
        AudioKit.output = trackedAmplitude
        try! AudioKit.start()
        oscillatorNode.start()
    }
    
    func next() {
        print(trackedAmplitude.amplitude)
    }
}
