//
//  MultiFieldCell.swift
//  MultiFieldRow
//
//  Created by Andrey Zelenin on 24.11.2017.
//  Copyright © 2017 Andrey Zelenin. All rights reserved.
//

import Foundation
import Eureka

struct SomeStruct: Equatable {
    var pushFieldValue: String
    var textField1Value: String
    var textField2Value: String
    
    init(_ pushFieldValue: String = "", _ textField1Value: String = "", _ textField2Value: String = "") {
        self.pushFieldValue = pushFieldValue
        self.textField1Value = textField1Value
        self.textField2Value = textField2Value
    }
}

func == (lhs: SomeStruct, rhs: SomeStruct) -> Bool {
    return lhs.pushFieldValue == rhs.pushFieldValue
}

final class MultiFieldCell: Cell<SomeStruct>, CellType {
    
    @IBOutlet var pushRowBtn: UIButton!
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    
    @IBAction func onTapPushRowBtn(_ sender: Any) {
        guard let tableView = self.tableView,
            let pushRow: PushRow<String> = row.section?.rowBy(tag: "hidden_values")
        else {
            return
        }
        
        pushRow.didSelect()
    }
    
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
    }
    
    override func update() {
        super.update()
        
        textField1.clearButtonMode =  .whileEditing
        textField2.clearButtonMode =  .whileEditing
        textField1?.text = nil
        textField2.text = nil
        
        // get the value from our row
        guard let data = row.value else {
            return
        }
        
        pushRowBtn.setTitle(data.pushFieldValue, for: .normal)
        textField1.text = data.textField1Value
        textField2.text = data.textField2Value
    }
}
