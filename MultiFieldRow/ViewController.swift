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
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = localCountries()
        
        let values: [FieldDataStruct] = [
            FieldDataStruct("Afghanistan", "WQ123456QQ"),
            FieldDataStruct("Brazil", "ER675431WW"),
            FieldDataStruct("Israel", "AS987654WW")
        ]
        
        form +++
            MultivaluedSection(
                multivaluedOptions: [.Reorder, .Insert, .Delete],
                header: "Multivalued Section"
            ) {
                $0.tag = "data"
                $0.addButtonProvider = { section in
                    return ButtonRow() {
                        $0.title = "Add new row"
                    }
                }
                
                for item in values {
                    $0 <<< MultiFieldRow() { row in
                        row.cell.lookupList = countries
                        row.value = item
                    }
                }
                
                $0.multivaluedRowToInsertAt = { index in
                    return MultiFieldRow() { row in
                        row.cell.lookupList = self.countries
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
    
    fileprivate func localCountries() -> [String] {
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String:String]]
                
                var countryNames = [String]()
                for country in jsonResult {
                    countryNames.append(country["name"]!)
                }
                
                return countryNames
            } catch {
                return []
            }
        }
        
        return []
    }
}
