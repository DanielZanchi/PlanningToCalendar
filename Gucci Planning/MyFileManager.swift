//
//  FileManager.swift
//  Gucci Planning
//
//  Created by Daniel Zanchi on 01/06/2018.
//  Copyright © 2018 Daniel Zanchi. All rights reserved.
//

import Foundation

class MyFileManager  {
    init() {
        
    }
    
    func createFile(content: String, name: String, month: String, path: String) {
        let file = "\(name) - \(month).ics" //this is the file. we will write to and read from it
        let text = content //just a text
        let originalFileURL = URL(fileURLWithPath: path)
        let pathWithoutLastComp = originalFileURL.deletingLastPathComponent()
        let dir = pathWithoutLastComp.appendingPathComponent(month)
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("eeror createing dir")
            print(error)
        }
        let fileURL = dir.appendingPathComponent(file)
            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */
                print("error creating file")
            }
    }
    
    func readFile(path: String) -> String{
        print(path)
        let fileURL = URL(fileURLWithPath: path)
        print(fileURL)
            //reading
            do {
                let text2 = try String(contentsOf: (fileURL), encoding: .utf8)
                return text2
            }
            catch {/* error handling here */}
//        }
        return ""
    }
    
    func replaceWithCommas(string: String) -> String {
        let s = string.replacingOccurrences(of: ";", with: ",", options: .literal, range: nil)
        return s
    }
}
