//
//  Controller.swift
//  Heist2
//
//  Created by rjm on 09/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class Controller {
    private var running = false
    private var scenes = Array<Scene>()
    private var currentScene = Scene(sceneID: 999)
    private var package = [UInt8](repeating: 0, count: 512)
    let uint8pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 512)
    internal var bpm = 80
    private var stepInterval = 0.0

    let audio = AudioFile.sharedAudio
    let interface = DMXController.shared()
    
    static let shared = Controller()
    
    init(){
        extractScenes()
    }
    
    func setBPM(bpm: Int) {
        self.bpm = bpm
        stepInterval = 60 / Double(self.bpm)
        print("bpm: \(bpm)")
    }
    
    //there should be a single reference to fixtures - at the moment theyre referenced in each scene
    //there should be a 'show' class that maintains 1 fix set and all the instructions
    func extractScenes() {
        let showIO = ShowIO()
        scenes = showIO.extractShow()
        currentScene = scenes[0]
        
        for scene in scenes {scene.primeScene()}
    }
    
    func loadScene(id: Int) {
        currentScene = scenes[id]
        print("Scene ID: \(currentScene.getID())")
    }
    
    func run() {
        if stepInterval == 0.0 {
            print("Please set bmp")
        } else {
            running = true
            if currentScene.getID() != 0 {audio.playFile()}
            steps()
            sends()
        }
    }
    
    func steps() {
        Timer.scheduledTimer(withTimeInterval: stepInterval, repeats: true) { timer in
            self.currentScene.step()
            
            if !self.running {timer.invalidate()}
        }
    }
    
    func sends() {
        Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { timer in
            self.package = self.currentScene.send() //this may be problematic
            self.uint8pointer.initialize(from: &self.package, count: 512)
            self.interface!.sendUniversePacket(self.uint8pointer)
            
            if !self.running {timer.invalidate()}
        }
    }
    
    func halt() {
        running = false
        if currentScene.getID() != 0 {audio.stopFile()}
        print("stopped")
    }
}
