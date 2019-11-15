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
        // didSet is called when property is set/assigned a new value - pressing enter after changing(pressing RSCP to event on screen
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
        //       let detailViewController = segue.description   // detailViewController is a UIViewcontroller
        
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
            }
        // we could set the event on the detail view controller
        detailViewController.event = event         // .event is variable created in DetailViewCOntroller class,,swift file
        }
    
    // unwind segue action
    // need to create an @IBAction for unwind segue
    // we need to commect th ecation buttom from th esource view
    // controller tyo this unwind segue action
    
    // unwind segue required to have parameter of type UIStoryboardSegue in
    // the unind segue action
    // why: this is the only way interface builder can recognize an unwind segue to connect to
    // MARK: - UNWIND SEGUE STEPS
    //  unwind segue - returning from a source view controller regular segue is ViewController A > ViewController B - unwind is B > A
    // 1. write an @IBAction func
    // 2. a UIStoryboard parameter is required
    // 3. type casrt and get access to the source view controller  (degue.source)
    // 4. setup ui accordingly --> see var event: Event! = detailsViewController.vent, didSet{...} on event property above^^^
    // 5. in storyboard control-drag action buttin to "exit" icon in the source view controller and select e.g this methos (uppdateUIFromUnwindSegue below)
    @IBAction func updateUIFromUnwindSegue(segue: UIStoryboardSegue) {
        // we need acess to the source destination view controller
        guard let detailsViewController = segue.source as? DetailViewController else {
            return  // more on refactoring to fatalError() later
        }
        
        event = detailsViewController.event
        
        
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
