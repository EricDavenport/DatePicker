//
//  ViewController.swift
//  DatePicker
//
//  Created by Eric Davenport on 11/14/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    // MARK:- Outlets and Propeties
    
    
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var rsvpLabel: UILabel!
    
    var event: Event! {
        didSet { // property observer, gets called when the property changes
                 //         update UI whenever the event changes
            if event.willAttend {
                // update label and button
                rsvpLabel.text = "RSVP YES"
                createEventButton.setTitle("View Event", for: .normal)
            } else {
                    rsvpLabel.text = "RSVP NO"
                    createEventButton.setTitle("RSVP to Event", for: .normal)
                }
            }
        }
    
    
    // MARK:- ViewController Life-Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // we need ti set the view controller as the delegate object
        // for the eventTextField
        // Date() creates )instances) a new Date object with the current date and tim
        event = Event(name: "Event Name not set", willAttend: false, date: Date())
        eventTextField.delegate = self
        
        datePicker.minimumDate = Date()

    }
    
    // MARK:- Actions and Methods

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        event.date = sender.date
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for(segue: )")
        // here is where we want to setup and pas event data to the detail view controller
        
        // 1. we need to ge an instanc eof the detail view controller
        //          is where we sr tanditioning to
        // segue.source is where the segue is coming from
        // segue.destination is where the segue is going
        //       let detailViewController = segue.description   // detailViewController is a UIViewco troller
        
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
            }
        // we could set the event on the detail view controller
        detailViewController.event = event
        }
        
    }
    



extension CreateEventViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // updating event's name
        event.name = eventTextField.text ?? "" // nil coellescing to unwrap
        return true
    }
    
    
    
}
