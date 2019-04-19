//
//  ViewController.swift
//  Gucci Planning
//
//  Created by Daniel Zanchi on 20/05/2018.
//  Copyright © 2018 Daniel Zanchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var progressIndiricator: NSProgressIndicator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressIndiricator.controlSize = .regular
        progressIndiricator.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(dragged), name: Notification.Name(rawValue: "dragged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finish), name: Notification.Name(rawValue: "finish"), object: nil)        
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    @objc func dragged() {
        progressIndiricator.isHidden = false
        progressIndiricator.startAnimation(self)
    }
    
    
    @objc func finish() {
        progressIndiricator.stopAnimation(self)
        progressIndiricator.isHidden = true

    }
}

