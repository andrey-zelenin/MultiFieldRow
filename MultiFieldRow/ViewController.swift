//
//  ViewController.swift
//  MultiFieldRow
//
//  Created by Andrey Zelenin on 24.11.2017.
//  Copyright © 2017 Andrey Zelenin. All rights reserved.
//

import UIKit
import Eureka

class ViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let values: [String] = [
            "First item",
            "Second item",
            "Third item"
        ]
        
        form +++
            MultivaluedSection(
                multivaluedOptions: [.Reorder, .Insert, .Delete],
                header: "Multivalued TextField"
            ) {
                $0.tag = "patient_insurances"
                $0.addButtonProvider = { section in
                    return ButtonRow() {
                        $0.title = "Add new row"
                    }
                }
                
                for item in values {
                    $0 <<< NameRow() {
                        $0.placeholder = "Tag Name"
                        $0.value = item
                    }
                }
                
                $0.multivaluedRowToInsertAt = { index in
                    return NameRow() {
                        $0.placeholder = "Tag Name"
                    }
                }
            }
            
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Get values"
                }
                .onCellSelection { row, cell in
                    print(self.form.values())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

