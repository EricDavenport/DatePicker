//
//  DetailViewController.swift
//  DatePicker
//
//  Created by Eric Davenport on 11/14/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!

    // ned objext from source view controller
    //we need (object)
    
    // event is of type Event? -- passed from CreateEventViewController
    var event: Event? // default value nil
    
    // DateFormatter will help ud format the date object in a more readable
    //              format
    // lazy variable - a variable that gets created the first time its needed
    //                  niot loaded as class comes on screen - only when called
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"  // .dateFormat we have more flexibility 
        //formatter.dateStyle  = .medium
        //formatter.timeStyle = .medium
        return formatter
    }()   // calls thids function (closure)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()

    }
    

func UpdateUI() {
    guard let date = event?.date else {
        return
    }
    selectedDateLabel.text = dateFormatter.string(from: date)
    
    
    
    // set switch position on value of willAttend, true or false
    // if true switch will be turned on, else switch will be turned off
    switchControl.isOn = event?.willAttend ?? false     // true or false
    
    messageLabel.text = event?.name ?? "Event name not available"
    
}
   
    
    @IBAction func rsvpCHANGED2(_ sender: UISwitch) {
        event?.willAttend = sender.isOn
    }
    
    
    
    
    
}
