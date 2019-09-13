//
//  UITableView+Ext.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerNib(with type: String ) {
        let nib = UINib(nibName: type, bundle: nil)
        self.register(nib, forCellReuseIdentifier: type)
    }
}
