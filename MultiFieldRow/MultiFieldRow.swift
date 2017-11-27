//
//  MultiFieldRow.swift
//  MultiFieldRow
//
//  Created by Andrey Zelenin on 24.11.2017.
//  Copyright © 2017 Andrey Zelenin. All rights reserved.
//

import Foundation
import Eureka

final class MultiFieldRow: Row<MultiFieldCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
        value = FieldDataStruct()
        cellProvider = CellProvider<MultiFieldCell>(nibName: "MultiFieldCell")
    }
}
