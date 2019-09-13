//
//  OrdersContentView.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class OrdersContentView: UIView {
    
    //MARK: - Outlets

    @IBOutlet weak var ordersTableView: UITableView! {
        didSet {
            ordersTableView.registerNib(with: ProductTableViewCell.reuseID())
            ordersTableView.registerNib(with: OrderTableViewCell.reuseID())
        }
    }
    
}
