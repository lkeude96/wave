//
//  CreateEventViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 11/27/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation
import Firebase

class CreateEventViewController: FormViewController {
    var eventsRef: FIRDatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        eventsRef = FIRDatabase.database().reference().child("events")
        
        view.backgroundColor = .white
        title = "Create an Event"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(self.handleCreate))
        
        initializeForm()
        
    }
    
    @objc private func handleCreate() {
        let valuesDictionary = form.values()
        
        let eventName = valuesDictionary["eventName"] as? String ?? ""
        let eventCost = valuesDictionary["eventCost"] as? Double ?? 0
        let eventDate = "Starts: \(valuesDictionary["eventStarts"] as? Date) Ends: \(valuesDictionary["eventEnds"] as? Date)"
        let eventLocation = "Name: \(valuesDictionary["locationName"] as? String ?? ""), Street address: \(valuesDictionary["streetAddress"] as? String ?? "") Apt/suite: \(valuesDictionary["aptSuite"] as? String ?? "") State: \(valuesDictionary["state"] as? String ?? "") Zip Code: \(valuesDictionary["zipCode"] as? String ?? "")"
        let createdBy = FIRAuth.auth()?.currentUser?.uid ?? ""
        
        let newEvent = Event(eventName: eventName, eventCost: eventCost, eventDate: eventDate, eventLocation: eventLocation, createdBy: createdBy)
        
        eventsRef.childByAutoId().setValue(newEvent.toJSONDict())
        
        print(valuesDictionary)
        let _ = SweetAlert().showAlert("Success!", subTitle: "Your event was created!", style: .success)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    private func initializeForm() {
        form = Section("What")
            <<< TextRow("eventName"){ row in
                row.title = "Event Name"
                row.placeholder = "Enter Event Name here"
            }
            <<< DecimalRow("eventCost"){
                $0.useFormatterDuringInput = true
                $0.title = "Cost"
                $0.value = 0
                let formatter = CurrencyFormatter()
                formatter.locale = .current
                formatter.numberStyle = .currency
                $0.formatter = formatter
            }
            +++ Section("When")
            <<< SwitchRow("isAllDay") {
                $0.title = "All-Day"
                $0.baseValue = false
                }.onChange { [weak self] row in
                    let startDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
                    let endDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
                    
                    if row.value ?? false {
                        startDate.dateFormatter?.dateStyle = .medium
                        startDate.dateFormatter?.timeStyle = .none
                        endDate.dateFormatter?.dateStyle = .medium
                        endDate.dateFormatter?.timeStyle = .none
                    }
                    else {
                        startDate.dateFormatter?.dateStyle = .short
                        startDate.dateFormatter?.timeStyle = .short
                        endDate.dateFormatter?.dateStyle = .short
                        endDate.dateFormatter?.timeStyle = .short
                    }
                    startDate.updateCell()
                    endDate.updateCell()
                    startDate.inlineRow?.updateCell()
                    endDate.inlineRow?.updateCell()
            }
            
            <<< DateTimeInlineRow("eventStarts") {
                $0.title = "Starts"
                $0.value = Date().addingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowBy(tag: "eventEnds")
                    if row.value?.compare(endRow.value!) == .orderedDescending {
                        endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
                        endRow.cell!.backgroundColor = .white
                        endRow.updateCell()
                    }
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowBy(tag: "isAllDay")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .date
                        }
                        else {
                            cell.datePicker.datePickerMode = .dateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            
            <<< DateTimeInlineRow("eventEnds"){
                $0.title = "Ends"
                $0.value = Date().addingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowBy(tag: "eventStarts")
                    if row.value?.compare(startRow.value!) == .orderedAscending {
                        row.cell!.backgroundColor = .red
                    }
                    else{
                        row.cell!.backgroundColor = .white
                    }
                    row.updateCell()
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowBy(tag: "isAllDay")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .date
                        }
                        else {
                            cell.datePicker.datePickerMode = .dateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            //            <<< ImageRow() {
            //                $0.title = "Image Row 2"
            //                $0.sourceTypes = .PhotoLibrary
            //                $0.clearAction = .no
            //                }
            //                .cellUpdate { cell, row in
            //                    cell.accessoryView?.layer.cornerRadius = 17
            //                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            //            }
            
            +++ Section("Where")
            //            <<< LocationRow(){
            //                $0.title = "LocationRow"
            //                $0.value =
            //        }
            
            <<< TextRow("locationName").cellSetup { cell, row in
                cell.textField.placeholder = "Location Name"
            }
            <<< TextRow("streetAddress").cellSetup {
                $1.cell.textField.placeholder = "Street Address"
            }
            <<< TextRow("aptSuite").cellSetup {
                $1.cell.textField.placeholder = "Apt/Suite"
            }
            <<< PickerInlineRow<String>("state") { (row: PickerInlineRow<String>) -> Void in
                row.title = "State"
                let states = ["Alaska",
                              "Alabama",
                              "Arkansas",
                              "American Samoa",
                              "Arizona",
                              "California",
                              "Colorado",
                              "Connecticut",
                              "District of Columbia",
                              "Delaware",
                              "Florida",
                              "Georgia",
                              "Guam",
                              "Hawaii",
                              "Iowa",
                              "Idaho",
                              "Illinois",
                              "Indiana",
                              "Kansas",
                              "Kentucky",
                              "Louisiana",
                              "Massachusetts",
                              "Maryland",
                              "Maine",
                              "Michigan",
                              "Minnesota",
                              "Missouri",
                              "Mississippi",
                              "Montana",
                              "North Carolina",
                              " North Dakota",
                              "Nebraska",
                              "New Hampshire",
                              "New Jersey",
                              "New Mexico",
                              "Nevada",
                              "New York",
                              "Ohio",
                              "Oklahoma",
                              "Oregon",
                              "Pennsylvania",
                              "Puerto Rico",
                              "Rhode Island",
                              "South Carolina",
                              "South Dakota",
                              "Tennessee",
                              "Texas",
                              "Utah",
                              "Virginia",
                              "Virgin Islands",
                              "Vermont",
                              "Washington",
                              "Wisconsin",
                              "West Virginia",
                              "Wyoming"]
                
                row.options = []
                
                for state in states {
                    row.options.append(state)
                }
            }
            <<< ZipCodeRow("zipCode").cellSetup {
                $1.cell.textField.placeholder = "Zip Code"
        }

    }
}
