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
        
        let values: [SomeStruct] = [
            SomeStruct("Value 1", "123456", "000000"),
            SomeStruct("Value 2", "675431", "111111"),
            SomeStruct("Value 3", "987654", "222222")
        ]
        
        form +++
            MultivaluedSection(
                multivaluedOptions: [.Reorder, .Insert, .Delete],
                header: "Multivalued Section"
            ) {
                $0.tag = "patient_insurances"
                $0.addButtonProvider = { section in
                    return ButtonRow() {
                        $0.title = "Add new row"
                    }
                }
                
                for item in values {
                    $0 <<< MultiFieldRow() { row in
                        row.value = item
                    }
                }
                
                $0.multivaluedRowToInsertAt = { index in
                    return MultiFieldRow() { row in
                        row.value = SomeStruct()
                    }
                }
                
                $0 <<< PushRow<String> {
                    $0.hidden = true
                    $0.tag = "hidden_values"
                    $0.options = ["Value1", "Value2", "Value3", "Value4", "Value5"]
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

