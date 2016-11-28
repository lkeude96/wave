//
//  CreateEventViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 11/27/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import Eureka

class CreateEventViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create an Event"
        
        form = Section("Basic info")
            <<< TextRow(){ row in
                row.title = "Event Name"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }

}
