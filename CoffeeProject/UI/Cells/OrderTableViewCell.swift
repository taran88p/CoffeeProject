//
//  OrderTableViewCell.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

protocol OrderTableViewCellDelegate: class {
    func createOrder()
}

class OrderTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var priceLabel: UILabel!
    weak var delegate: OrderTableViewCellDelegate?
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Configure
    
    func configure(price: Double) {
        priceLabel.text = String(price)
    }
    
    //MARK: - Configure Layout
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 100)
    }
    
    //MARK: - Action
    
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        delegate?.createOrder()
    }
    
    //MARK: - Other
    
    class func reuseID() -> String {
        return NSStringFromClass(OrderTableViewCell.self).components(separatedBy: ".").last!
    }
}
