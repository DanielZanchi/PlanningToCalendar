//
//  AppDelegate.swift
//  Gucci Planning
//
//  Created by Daniel Zanchi on 20/05/2018.
//  Copyright © 2018 Daniel Zanchi. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        print(filename)
        return true
    }
    
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        print(filenames)
    }


}

