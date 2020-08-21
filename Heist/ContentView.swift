//
//  ContentView.swift
//  Heist
//
//  Created by rjm on 24/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let controller = Controller.shared
    @State var running = false
    @State var bpm: String = ""
    @State var scene: String = "..."
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Heist")
                .font(.title)
            HStack {
                Text("Set BPM")
                    .font(.subheadline)
                Spacer()
                TextField("", text: $bpm)
                    .frame(width: 48.0)
                    .border(Color.black)
                    
                Button(action: {
                    if self.bpm == "" {print("please insert bpm value")}
                    else {
                        self.controller.setBPM(bpm: Int(self.bpm)!)
                    }
                }) {
                    Text("Set")
                }
            }
            
            HStack {
                Text("Select Scene")
                    .font(.subheadline)
                Spacer()
                MenuButton("\(scene)") {
                    Button("Test Scene") {
                        self.scene = "Test Scene"
                        self.controller.loadScene(id: 0)
                    }
                    Button("Amp Match") {
                        self.scene = "Amp Match"
                        self.controller.loadScene(id: 1)
                    }
                    Button("Freq Match") {
                        self.scene = "Freq Scene"
                        self.controller.loadScene(id: 2)
                    }
                }
                .frame(width: 110.0)
            }
            
            HStack {
                Text("Control")
                    .font(.subheadline)
                Spacer()
                Button(action: {
                    self.running = true
                    self.controller.run()
                }) {
                    Text("Run")
                }
                Button(action: {
                    self.running = true
                    self.controller.halt()
                }) {
                    Text("Halt")
                }
            }
        }
    .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

