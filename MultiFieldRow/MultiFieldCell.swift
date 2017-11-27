//
//  MultiFieldCell.swift
//  MultiFieldRow
//
//  Created by Andrey Zelenin on 24.11.2017.
//  Copyright © 2017 Andrey Zelenin. All rights reserved.
//

import Foundation
import Eureka

struct FieldDataStruct: Equatable {
    var textField1Value: String
    var textField2Value: String
    
    init(_ textField1Value: String = "", _ textField2Value: String = "") {
        self.textField1Value = textField1Value
        self.textField2Value = textField2Value
    }
}

func == (lhs: FieldDataStruct, rhs: FieldDataStruct) -> Bool {
    return lhs.textField1Value == rhs.textField1Value && lhs.textField2Value == rhs.textField2Value
}

final class MultiFieldCell: Cell<FieldDataStruct>, UITextFieldDelegate, CellType {
    
    @IBOutlet var tField1: SearchTextField!
    @IBOutlet var tField2: UITextField!
    
    var lookupList = [String]()
    
    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        
        // we do not want our cell to be selected in this case. If you use such a cell in a list then you might want to change this.
        selectionStyle = .none
        
        for field in [tField1, tField2] {
            field?.addTarget(self, action: #selector(MultiFieldCell.textFieldDidEndEditing(_:)), for: .editingDidEnd)
            field?.delegate = self
        }
    }
    
    override func update() {
        super.update()
        
        tField1.inlineMode = true
        // Set data source
        tField1.filterStrings(lookupList)
        
        // get the value from our row
        guard let data = row.value else {
            return
        }
        
        tField1.text = data.textField1Value
        tField2.text = data.textField2Value
    }
    
    @objc open func textFieldDidEndEditing(_ textField: UITextField) {
        updateValuesForTextField(textField)
    }
    
    func updateValuesForTextField(_ textField: UITextField) {
        switch(textField) {
            case tField1:
                row.value?.textField1Value = textField.text ?? ""
            case tField2:
                row.value?.textField2Value = textField.text ?? ""
            default: break
        }
    }
}
