//
//  ViewController.swift
//  Gucci Planning
//
//  Created by Daniel Zanchi on 20/05/2018.
//  Copyright © 2018 Daniel Zanchi. All rights reserved.
//

import Cocoa
import iCalKit
import CSV

class ViewController: NSViewController {
    
    //    let symbolDictionary: [String: String] = [
    //        "L": "Libero",
    //        "a": "Apertura",
    //        "11": "Chiusura",
    //        "$": "$"
    //    ]
    
    let monthDictionary: [String: String] = ["GIUGNO": "06", "LUGLIO": "07"]
    let dayNames = ["D","M","ME","G","V","S"]
    
    var content: String!
    var month: String!
    var monthInNumber: Int!
    var dayName: [String]!
    var nameAndHours: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var events = [Event]()
        
        let fileString = readFile()
        print(fileString)
        let CSVString = replaceWithCommas(string: fileString)
        let csv = try! CSVReader(string: CSVString)
        
        //parse CSV file
        while let row = csv.next() {
            let first = (row.first)?.uppercased()
            if monthDictionary.keys.contains(first!) {
                month = first
            }
            else {
                if first != "" {
                    nameAndHours = row
                }
                if row.count > 2 {
                    let second = (row[1]).uppercased()
                    let third = (row[2]).uppercased()
                    if dayNames.contains(second) || dayNames.contains(third) {
                        print("saved")
                        print(second)
                        dayName = row
                    }
                }
                
            }
        }
        
        for m in monthDictionary {
            if m.key == month {
                monthInNumber = Int(m.value)
            }
        }
        monthInNumber = 4 //delete
        
        //parse Hours
        var h: Int!
        var min: Int!
        var y = 2018
        var name: String!
        
        print()
        print(dayName)
        nameAndHours.removeFirst()
        dayName.removeFirst()
        var day = 0
        for symbol in nameAndHours {
            day = day + 1
            print(day, dayName[day-1])
            
            switch symbol {
            case "a":
                h = 9
                min = 0
                name = "Apertura"
            case "11":
                h = 11
                min = 0
                name = "Chiusura"
            case "":
                h = 10
                min = 0
                name = "Normale"
            case "X":
                h = 10
                min = 0
                name = "Normale"
            case "$":
                h = 10
                min = 30
                name = "$"
            default:
                h = 0
                min = 0
            }
            if h != 0 {
                let start = createDate(year: y, month: monthInNumber, day: day, hour: h, minute: min)
                let end = createDate(year: y, month: monthInNumber, day: day, hour: h, minute: min)
                let event = createEvent(start: start, end: end, name: name)
                events.append(event)
            }
        }
        
        //        let start = createDate(year: 2018, month: 07, day: 3, hour: 11, minute: 00)
        //        let end = createDate(year: 2018, month: 07, day: 3, hour: 20, minute: 00)
        //        let event = createEvent(start: start, end: end, name: "Chiusura")
        //
        //        let start2 = createDate(year: 2018, month: 07, day: 4, hour: 9, minute: 00)
        //        let end2 = createDate(year: 2018, month: 07, day: 4, hour: 18, minute: 00)
        //        let event2 = createEvent(start: start2, end: end2, name: "Apertura")
        //
        let calendar = Calendar(withComponents: events)
        content = calendar.toCal()
        createFile(content: content, month: "April")
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func createEvent(start: Date, end: Date, name: String) -> Event{
        var event = Event()
        let startDate = start
        event.summary = name
        event.dtstart = startDate
        let endDate = end
        event.dtend = endDate
        return event
    }
    
    func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.timeZone = TimeZone.current
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        return date!
    }
    
    func createFile(content: String, month: String) {
        let file = "\(month).ics" //this is the file. we will write to and read from it
        let file2 = "Book1.csv"
        let text = content //just a text
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */
                print("error creating file")
            }
            
        }
    }
    
    func readFile() -> String{
        let file = "Book1.csv"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                return text2
            }
            catch {/* error handling here */}
        }
        return ""
    }
    
    func replaceWithCommas(string: String) -> String {
        let s = string.replacingOccurrences(of: ";", with: ",", options: .literal, range: nil)
        return s
    }
    
}

