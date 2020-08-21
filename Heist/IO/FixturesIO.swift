//
//  ControllerIO.swift
//  Heist1
//
//  Created by rjm on 14/02/2020.
//  Copyright © 2020 rjm. All rights reserved.
//

import Foundation

class FixturesIO: Codable {
        
        func read() -> Fixtures? {
            let fm = FileManager()
            //print("file manager")
            guard let mainUrl = Bundle.main.url(forResource: "firstFixScene", withExtension: "json") else {
                print("err")
                return nil}
            //print(mainUrl)
            do {
                let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                let subUrl = documentDirectory.appendingPathComponent("firstFixScene.json")
                return loadFile(mainPath: mainUrl, subPath: subUrl, fm: fm)
            } catch {
                print(error)
            }
            return nil
        }
        
        
        func loadFile(mainPath: URL, subPath: URL, fm: FileManager) -> Fixtures {
            //print("loadFile")
            if fm.fileExists(atPath: subPath.path){
                return decodeData(pathName: subPath)!
            }else{
                return decodeData(pathName: mainPath)!
            }
        }
        
        func decodeData(pathName: URL) -> Fixtures? {
            //print("decode data")
            do{
                let jsonData = try Data(contentsOf: pathName)
                let decoder = JSONDecoder()
                
                do {
                    let fixs = try decoder.decode(Fixtures.self, from: jsonData)
                    return fixs
                } catch {
                    print(error.localizedDescription)
                }
                
            } catch let error {print(error)}
            return nil
        }
}

