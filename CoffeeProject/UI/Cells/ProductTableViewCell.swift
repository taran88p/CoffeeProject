//
//  ProductTableViewCell.swift
//  CoffeeProject
//
//  Created by Pavel on 8/10/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: class {
    func addedCoffeeToOrder(tag: Int, value: Double)
}

class ProductTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var headerPriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var footerPriceLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    
    //MARK: - Variables
    
    var value: CGFloat = 1.0
    var borderColor = UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 46.0/255.0, alpha: 1.0)
    weak var delegate: ProductTableViewCellDelegate?
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conteinerView.layer.borderColor = borderColor.cgColor
        conteinerView.layer.borderWidth = value
    }
    
    //MARK: - Configure
    
    func configure(product: Product, index: Int, countCups: Double) {
        titleImageView.image = UIImage(named: product.image)
        shortDescriptionLabel.text = product.shortDescription
        countStepper.tag = index
        footerPriceLabel.text = setupPrice(countCups: countCups, price: product.price)
        headerPriceLabel.text = setupPrice(countCups: countCups, price: product.price)
    }
    
    //MARK: - Update Cell
    
    func expandCell(product: Product, countCups: Double) {
        footerPriceLabel.text = setupPrice(countCups: countCups, price: product.price)
        descriptionLabel.text = product.description
        animation(expandAlpha: 0.0, colapseAlpha: value)
    }
    
    func colapseCell() {
        animation(expandAlpha: value, colapseAlpha: 0.0)
        descriptionLabel.text = nil
    }
    
    //MARK: - Animation
    
    func animation(expandAlpha: CGFloat, colapseAlpha: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.footerPriceLabel.alpha = colapseAlpha
            self.headerPriceLabel.alpha = expandAlpha
            self.shortDescriptionLabel.alpha = expandAlpha
            self.descriptionLabel.alpha = colapseAlpha
        }
    }
    
    //MARK: - Action
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        delegate?.addedCoffeeToOrder(tag: sender.tag, value: sender.value)
    }
    
    //MARK: - Other
    
    func setupPrice(countCups: Double, price: Double) -> String {
        var countCupsString = String(format: "%.f x ", countCups)
        if countCups == 0 {
            countCupsString = ""
        }
        return countCupsString + String(format: "%.2f", price)
    }
    
    class func reuseID() -> String {
        return NSStringFromClass(ProductTableViewCell.self).components(separatedBy: ".").last!
    }
}
