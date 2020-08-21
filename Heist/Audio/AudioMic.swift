////
////  AudioMic.swift
////  Heist2
////
////  Created by rjm on 22/03/2020.
////  Copyright © 2020 rjm. All rights reserved.
////
//
//import Foundation
//import AudioKit
//import AudioKitUI
//import Cocoa
//
//class AudioMic {
//    let mic: AKMicrophone!
//    let tracker: AKFrequencyTracker!
//    let silence: AKBooster!
//    
//    init() {
//        AKSettings.audioInputEnabled = true
//        mic = AKMicrophone()
//        tracker = AKFrequencyTracker(mic)
//        silence = AKBooster(tracker, gain: 0)
//
//        AudioKit.output = silence
//        do {
//            try AudioKit.start()
//        } catch {
//            AKLog("AudioKit did not start!")
//        }
//    }
//    
//    func printAmp() {
//        if tracker.amplitude > 0.1 {
//            let trackerFrequency = Float(tracker.frequency)
//            
//            guard trackerFrequency < 7_000 else {
//                // This is a bit of hack because of modern Macbooks giving super high frequencies
//                return
//            }
//                
//            print(String(format: "%0.1f", tracker.frequency))
//            print(String(format: "%0.2f", tracker.amplitude))
//        } else {print("amp < 0.1")}
//    }
//}
//
////    var mic = AKMicrophone()
////    let audioBus = 0
////    let bufferSize : UInt32 = 4096
////
////    init() {initMicrophone()}
////
////    func initMicrophone() {
////        // Facultative, allow to set the sampling rate of the microphone
////        AKSettings.sampleRate = 44100
////
////        // Link the microphone note to the output of AudioKit with a volume of 0.
////        AudioKit.output = AKBooster(mic, gain:0)
////
////        // Start AudioKit engine
////        try! AudioKit.start()
////
////        // Add a tap to the microphone
////        mic?.avAudioNode.installTap(onBus: audioBus,
////                                    bufferSize: bufferSize,
////                                    format: nil) // I choose a buffer size of 4096
////            { [weak self] (buffer, _) in //self is now a weak reference, to prevent retain cycles
////
////            // We try to create a strong reference to self, and name it strongSelf
////            guard let strongSelf = self else {
////                print("Recorder: Unable to create strong reference to self #1")
////                return
////            }
////
////            // We look at the buffer if it contains data
////            buffer.frameLength = strongSelf.bufferSize
////            let offset = Int(buffer.frameCapacity - buffer.frameLength)
////            if let tail = buffer.floatChannelData?[0] {
////                // We convert the content of the buffer to a swift array
////                let samples = Array(UnsafeBufferPointer(start: &tail[offset], count: 4096))
////                strongSelf.next(data:samples)
////            }
////        }
////    }
////
////    func next(data:[Float]) {
////        print(data[100])
////    }
//
//
