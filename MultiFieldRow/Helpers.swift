//
//  Helpers.swift
//  MultiFieldRow
//
//  Created by Andrey Zelenin on 24.11.2017.
//  Copyright © 2017 Andrey Zelenin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}
