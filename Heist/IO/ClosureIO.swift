//
//  ClosureIO.swift
//  Heist2
//
//  Created by rjm on 09/03/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class ClosureIO {
    
    func read() -> SceneIO? {
        let fm = FileManager()
        //print("file manager")
        guard let mainUrl = Bundle.main.url(forResource: "instructions", withExtension: "json") else {
            print("closure IO read error")
            return nil}
        //print(mainUrl)
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let subUrl = documentDirectory.appendingPathComponent("instructions.json")
            return loadFile(mainPath: mainUrl, subPath: subUrl, fm: fm)
        } catch {
            print(error)
        }
        return nil
    }
    
    
    func loadFile(mainPath: URL, subPath: URL, fm: FileManager) -> SceneIO {
        //print("loadFile")
        if fm.fileExists(atPath: subPath.path){
            return decodeData(pathName: subPath)!
        }else{
            return decodeData(pathName: mainPath)!
        }
    }
    
    func decodeData(pathName: URL) -> SceneIO? {
        //print("decode data")
        do{
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            
            do {
                let scenes = try decoder.decode(SceneIO.self, from: jsonData)
                return scenes
            } catch {
                print(error.localizedDescription)
            }
            
        } catch let error {print(error)}
        return nil
    }
    
}
