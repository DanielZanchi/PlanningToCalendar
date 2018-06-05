//
//  DestinationView.swift
//  Gucci Planning
//
//  Created by Daniel Zanchi on 05/06/2018.
//  Copyright © 2018 Daniel Zanchi. All rights reserved.
//

import Cocoa



class DestinationView: NSView {
    var fileManager: MyFileManager!
    
    let monthDictionary: [String: String] = ["GIUGNO": "06", "LUGLIO": "07", "AGOSTO": "08"]
    let dayNames = ["D","M","ME","G","V","S"]
    
    var content: String!
    var month: String!
    var monthInNumber: Int!
    var dayName: [String]!
    var nameAndHours: [String]!
    
    
    var filePath: String!
    var fileTypes = ["csv"]
    
    let types = NSPasteboard.PasteboardType("NSFilenamesPboardType")
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
        self.registerForDraggedTypes([types])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if let pasteboard = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray {
            if let path = pasteboard[0] as? String {
                let ext = NSURL(fileURLWithPath: path).pathExtension
                if checkExtension(ext: ext!) {
                    self.layer?.backgroundColor = NSColor.green.cgColor
                    return NSDragOperation.copy
                }
                else {
                    print(ext!)
                    self.layer?.backgroundColor = NSColor.red.cgColor
                }
            }
        }
        return NSDragOperation.delete
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        if let pasteboard = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray {
            if let path = pasteboard[0] as? String {
                let ext = NSURL(fileURLWithPath: path).pathExtension
                if checkExtension(ext: ext!) {
                    self.layer?.backgroundColor = NSColor.blue.cgColor
                    self.launchConverter(path: path)
                    return true
                }
            }
        }
        return false
    }
    
    func checkExtension(ext: String) -> Bool {
        for goodExt in self.fileTypes {
            if goodExt.lowercased() == ext.lowercased() {
                return true
            }
        }
        return false
    }
    
}
